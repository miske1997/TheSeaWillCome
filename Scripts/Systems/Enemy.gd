class_name Enemy extends CharacterBody2D

@export var enemyConfig: EnemyConfig

var health

func _ready() -> void:
	health = enemyConfig.health

func takeDamage(damage: int):
	health -= damage
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()
