extends RigidBody2D

var direction: Vector2
var speed: float

func _ready() -> void:
	apply_impulse(direction * speed)
	
func _on_body_entered(body: Node) -> void:
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
