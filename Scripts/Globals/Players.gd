extends Node

var playerCharacter: Node : set = _set_character
var playerName: String
var highScore: int
var resources: Dictionary[String, ResourceData] : get = _get_resources
var _resourceData: Resources
var carryCapacity: int = 8
var weightInBackpack: int = 0 : set = _set_weight_in_backpack
var character: Player

signal carryWeightChanged

func add_resource_to_backpack(resourceName, amount, weight):
	_resourceData.set_resource_amount(resourceName, resources[resourceName].amount + amount)
	weightInBackpack += weight

func _get_resources():
	return _resourceData.resources

func _set_weight_in_backpack(value: int) -> void:
	weightInBackpack = value
	carryWeightChanged.emit()

func _set_character(value: Node):
	Events.onPlayerCharacterChanged.emit(value)
	playerCharacter = value
