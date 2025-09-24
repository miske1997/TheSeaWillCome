class_name Axe extends Tool

@onready var timer: Timer = $Timer
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

func _ready() -> void:
	activate.connect(activate_tool)
	timer.wait_time = toolConfig.mineSpeed

func _process(delta: float) -> void:
	if not enabled:
		return
	look_at_target()
	$RayCast2D.position = global_position
	$RayCast2D.target_position = get_local_mouse_position().normalized() * 10
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
	look_at(get_global_mouse_position())

func mine() -> void:
	if not inUse:
		return
	var tree = $RayCast2D.get_collider().get_parent()
	var minedAmount = toolConfig.mineAmount
	if toolConfig.mineAmount > tree.amount:
		minedAmount = tree.amount
	
	tree.amount -= toolConfig.mineAmount
	var resourceName = tree.type
	
	GameData._resourceData.set_resource_amount(resourceName, GameData.castleResources[resourceName].amount + minedAmount)
	
	if tree.amount <= 0:
		#animate
		deactivate_tool()
		tree.queue_free()

func activate_tool() -> void:
	if not $RayCast2D.get_collider():
		return
	inUse = true
	timer.start()

func deactivate_tool() -> void:
	inUse = false
	timer.stop()
