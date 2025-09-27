class_name Level extends Node2D


func focus():
	visible = true
	Players.character.position = $PlayerSpawn.global_position
	Players.character.light_on()
	get_tree().get_first_node_in_group("Camera").position = Players.character.position - get_viewport_rect().size / 2
	
func un_focus():
	visible = false
	
func init():
	get_node("Lighting").modulate = Color.from_rgba8(1, 1, 1)
	
