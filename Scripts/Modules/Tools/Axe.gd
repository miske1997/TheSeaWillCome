class_name Axe extends Tool

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
	
	var tree = $RayCast2D.get_collider().get_parent()
	
	var amount = tree.amount
	var resourceName = tree.type
	Players._resourceData.set_resource_amount(resourceName, Players.resources[resourceName].amount + amount)
	
	await get_tree().create_timer(tree.mineTime).timeout
	tree.queue_free()
	
