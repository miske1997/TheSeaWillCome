class_name Bow extends Tool

@export var attack_speed := 1.0

@onready var timer: Timer = $Timer

var targetLocation: Vector2

func _ready() -> void:
	activate.connect(activate_tool)
	timer.wait_time = attack_speed

func _process(delta: float) -> void:
	if not enabled:
		return
	look_at_target()
	if Input.is_action_just_pressed("Click"):
		activate_tool()
	if Input.is_action_just_released("Click"):
		deactivate_tool()

func look_at_target():
	if targetLocation:
		look_at(targetLocation)

func activate_tool() -> void:
	inUse = true
	timer.start()

func deactivate_tool() -> void:
	inUse = false
	timer.stop()
