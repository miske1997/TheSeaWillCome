class_name Pick extends Tool

func _ready() -> void:
	activate.connect(activate_tool)
	
func _process(delta: float) -> void:
	look_at_target()
	$RayCast2D.target_position = get_global_mouse_position()
	if Input.is_action_just_pressed("Click"):
		activate_tool()

func look_at_target():
	look_at(get_global_mouse_position())
	
func activate_tool() -> void:
	if not $RayCast2D.get_collider():
		return
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("TileMap")
	var tileCoords := tilemap.local_to_map($RayCast2D.get_collision_point())
	var data := tilemap.get_cell_tile_data(tileCoords)
	if data == null:
		return
		
	var amount = data.get_custom_data("ResourceAmount")
	var resourceName: String = data.get_custom_data("Type")
	var mineTime: float = data.get_custom_data("mineTime")
	Players._resourceData.set_resource_amount(resourceName, Players.resources[resourceName].amount + amount)
	await get_tree().create_timer(mineTime).timeout
	tilemap.erase_cell(tileCoords) 
	
