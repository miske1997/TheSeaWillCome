class_name Pick extends Tool

@onready var timer: Timer = $Timer
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

func _ready() -> void:
	activate.connect(activate_tool)
	
func _process(delta: float) -> void:
	if not enabled:
		return
	look_at_target()
	$RayCast2D.position = global_position
	$RayCast2D.target_position = get_local_mouse_position()
	$RayCast2D.rotation = rotation
	if Input.is_action_just_pressed("Click"):
		activate_tool()
	if Input.is_action_just_released("Click"):
		deactivate_tool()
	if inUse:
		path_follow_2d.progress_ratio = (toolConfig.mineSpeed - timer.time_left) / toolConfig.mineSpeed
	else:
		path_follow_2d.progress_ratio = 0

func look_at_target():
	#look_at(get_global_mouse_position())
	pass
	
	
func mine() -> void:
	if not inUse:
		return
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("TileMap")
	var tileCoords := tilemap.local_to_map($RayCast2D.get_collision_point())
	if not tilemap.get_cell_tile_data(tileCoords):
		return
	var data := tilemap.get_cell_tile_data(tileCoords)
	var amount = data.get_custom_data("ResourceAmount")
	var resourceName: String = data.get_custom_data("Type")
	var minedAmount = toolConfig.mineAmount
	if toolConfig.mineAmount > amount:
		minedAmount = amount
	
	amount -= toolConfig.mineAmount
	Players._resourceData.set_resource_amount(resourceName, Players.resources[resourceName].amount + minedAmount)
	
	if amount <= 0:
		#animate
		deactivate_tool()
		mine_block()

func mine_block():
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("TileMap")
	var outlineTiles: TileMapLayer = tilemap.get_parent().get_node("Outlines")
	var tileCoords := tilemap.local_to_map($RayCast2D.get_collision_point())
	tilemap.erase_cell(tileCoords) 
	outlineTiles.erase_cell(tileCoords)

func activate_tool() -> void:
	if not $RayCast2D.get_collider():
		return
	inUse = true
	timer.start()
	

func deactivate_tool() -> void:
	inUse = false
	timer.stop()
