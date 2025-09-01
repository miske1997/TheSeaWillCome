extends Node

var effectAdresses: Dictionary[String, String] = {}

var maxEffectsAtATime := 20
var currentlyPlaying := 0

func play_effect_at_position(effectName: String, position: Vector2) -> void:
	if not effectAdresses.has(effectName):
		return
	if currentlyPlaying == maxEffectsAtATime:
		return
	currentlyPlaying += 1
	var effect: Node2D = load(effectAdresses[effectName]).instantiate()
	effect.position = position
	get_tree().get_first_node_in_group("Temp").get_node("Effects").add_child(effect)
	await effect.tree_exited
	currentlyPlaying -= 1
