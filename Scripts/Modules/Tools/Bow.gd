class_name Bow extends Tool

@export var attack_speed := 1.0
@export var arrow: PackedScene
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
	var projectile = arrow.instantiate()
	projectile.direction = Vector2.from_angle(rotation)
	projectile.speed = 300.0
	get_tree().root.add_child(projectile)
	projectile.position = global_position + projectile.direction * 10
	#inUse = true
	#timer.start()

func deactivate_tool() -> void:
	inUse = false
	timer.stop()
