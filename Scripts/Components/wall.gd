extends Node2D

@export var health := 10
var imune := false

func take_damage(damage):
	if imune:
		return
	health -= damage
	imune = true
	if health <= 0:
		queue_free()
	else:
		imune = true
		await get_tree().create_timer(0.2).timeout
		imune = false
