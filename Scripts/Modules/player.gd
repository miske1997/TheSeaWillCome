class_name Player extends CharacterBody2D

@export var SPEED = 300.0
const JUMP_VELOCITY = -220.0
var wallJumpDuration := 0.3
var wallJumpTimeout := 0.0
@onready var wall_detect: RayCast2D = $WallDetect

var look_dir = 1

func _ready() -> void:
	light_off()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if  Input.is_action_just_pressed("ui_accept") and wall_detect.get_collider() and not is_on_floor():
		velocity.y = JUMP_VELOCITY * 1.2
		velocity.x = sign(wall_detect.target_position.x) * -SPEED
		wall_detect.target_position.x *= -1 
		wallJumpTimeout = wallJumpDuration
		
	if wallJumpTimeout > 0:
		wallJumpTimeout -= delta
		move_and_slide()
		return
	
	var direction := Input.get_axis("Left", "Right")
	wall_detect.target_position.x = direction * 3.5
	if direction != 0:
		if look_dir != direction:
			scale.x = -1
			look_dir = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
func take_damage(damage: int):
	print("HIT ME")

func light_on():
	$Light.enabled = true
	
func light_off():
	$Light.enabled = false
