extends Node


var currentLevel: Node : set = _set_current_level
var saveData: SaveData
var settings
var controllerConected := false

func _set_current_level(value: Node):
	Events.onCurrentLevelChanged.emit(value)
	currentLevel = value
