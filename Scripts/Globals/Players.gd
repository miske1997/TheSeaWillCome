extends Node


var playerCharacter: Node : set = _set_character
var playerName: String
var highScore: int
var resources: Dictionary[String, ResourceData] : get = _get_resources
var _resourceData: Resources

func _get_resources():
	return _resourceData.resources

func _set_character(value: Node):
	Events.onPlayerCharacterChanged.emit(value)
	playerCharacter = value
