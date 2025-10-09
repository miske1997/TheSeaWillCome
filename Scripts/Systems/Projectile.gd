extends RigidBody2D

var direction: Vector2
var speed: float

func _ready() -> void:
	apply_impulse(direction * speed)
	

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if not body is TileMapLayer and body.get_collision_layer_value(2):
		DealDamage.deal_damage(1, body)
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	queue_free()
