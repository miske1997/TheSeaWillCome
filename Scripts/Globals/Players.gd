extends Node


var playerCharacter: Node : set = _set_character
var playerName: String
var highScore: int

func _set_character(value: Node):
	Events.onPlayerCharacterChanged.emit(value)
	playerCharacter = value
