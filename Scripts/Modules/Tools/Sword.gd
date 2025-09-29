class_name Sword extends Tool

@export var attack_speed := 1.0

@onready var timer: Timer = $Timer
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

var hit: Array[Enemy] = []

func _ready() -> void:
	activate.connect(activate_tool)
	timer.wait_time = attack_speed

func _process(delta: float) -> void:
	if not enabled:
		return
	if Input.is_action_just_pressed("Click"):
		activate_tool()
	if Input.is_action_just_released("Click"):
		deactivate_tool()
	if inUse:
		path_follow_2d.progress_ratio = (timer.wait_time - timer.time_left) / timer.wait_time
	else:
		path_follow_2d.progress_ratio = 0



func activate_tool() -> void:
	inUse = true
	timer.start()
	hit = []

func deactivate_tool() -> void:
	inUse = false
	timer.stop()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not inUse:
		return
	if not body is Enemy:
		return
	if body in hit:
		return
	hit.push_back(body)
	DealDamage.deal_damage(1, body)

func _on_swing_ended() -> void:
	hit = []
