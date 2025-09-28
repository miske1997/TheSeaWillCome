class_name Pick extends Tool

@onready var timer: Timer = $Timer
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

var tilemap: TileMapLayer
func _ready() -> void:
	activate.connect(activate_tool)
	
func _process(delta: float) -> void:
	if not enabled:
		return
	look_at_target()
	#$RayCast2D.global_position = global_position
	$RayCast2D.target_position = get_local_mouse_position()
	$RayCast2D.rotation = rotation
	if Input.is_action_just_pressed("Click"):
		activate_tool()
	if Input.is_action_just_released("Click"):
		deactivate_tool()
	if inUse:
		path_follow_2d.progress_ratio = (timer.wait_time - timer.time_left) / timer.wait_time
	else:
		path_follow_2d.progress_ratio = 0

func look_at_target():
	#look_at(get_global_mouse_position())
	pass
	
	
func mine() -> void:
	if not inUse:
		return
	var tileCoords := tilemap.local_to_map($RayCast2D.get_collision_point() - tilemap.global_position)
	if not tilemap.get_cell_tile_data(tileCoords):
		return
	var data := tilemap.get_cell_tile_data(tileCoords)
	var amount = data.get_custom_data("ResourceAmount")
	var resourceName: String = data.get_custom_data("Type")
	var weight: int = data.get_custom_data("Weight")
	var mineTime: int = data.get_custom_data("MineTime")
	
	if Players.weightInBackpack + weight > Players.carryCapacity:
		return
	var minedAmount = toolConfig.mineAmount
	if toolConfig.mineAmount > amount:
		minedAmount = amount
	
	amount -= toolConfig.mineAmount
	Players.add_resource_to_backpack(resourceName, minedAmount, weight)
	
	if amount <= 0:
		#animate
		deactivate_tool()
		mine_block()
	else:
		data.set_custom_data("ResourceAmount", amount)

func mine_block():
	var outlineTiles: TileMapLayer = tilemap.get_parent().get_node("Outlines")
	var tileCoords := tilemap.local_to_map($RayCast2D.get_collision_point() - tilemap.global_position)
	tilemap.erase_cell(tileCoords) 
	outlineTiles.erase_cell(tileCoords)

func activate_tool() -> void:
	if not $RayCast2D.get_collider():
		return
	tilemap = $RayCast2D.get_collider()
	var tileCoords := tilemap.local_to_map($RayCast2D.get_collision_point() - tilemap.global_position)
	if not tilemap.get_cell_tile_data(tileCoords):
		return
	var data := tilemap.get_cell_tile_data(tileCoords)
	var weight: int = data.get_custom_data("Weight")
	var mineTime: int = data.get_custom_data("MineTime")
	timer.wait_time = mineTime * toolConfig.mineSpeed
	inUse = true
	timer.start()
	

func deactivate_tool() -> void:
	inUse = false
	timer.stop()
