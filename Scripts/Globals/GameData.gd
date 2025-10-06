extends Node


var currentLevel: Node : set = _set_current_level
var saveData: SaveData
var settings
var controllerConected := false
var gameTime: int = 0
var gameTotalTime: int = 10
var nightTime: bool = false
var castleResources: Dictionary[String, ResourceData] : get = _get_resources
var _resourceData: Resources = preload("res://Data/castleResources.tres")
var workers: Array = []
var day := 0

func _get_resources():
	return _resourceData.resources


func _set_current_level(value: Node):
	Events.onCurrentLevelChanged.emit(value)
	currentLevel = value

func decrement_resource_amount(resourceName: String, amount: int):
	_resourceData.set_resource_amount(resourceName, castleResources[resourceName].amount - amount)

func increment_resource_amount(resourceName: String, amount: int):
	_resourceData.set_resource_amount(resourceName, castleResources[resourceName].amount + amount)
