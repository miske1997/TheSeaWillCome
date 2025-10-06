extends Node

@export var spawnOffset = 30

var leftMostBuilding: Vector2
var rightMostBuilding: Vector2


var spawnAlovence = [3, 10, 12]
var enemyValues = {"walking_fish": 1}

func _ready() -> void:
	Events.nightFall.connect(on_nightfall)
	Events.buildingBuilt.connect(on_building_built)
	
func on_nightfall():
	get_node("Left").start_spawning(spawnAlovence[GameData.day])

func get_left_spawn_position() -> Vector2:
	var playerPos = Players.character.position
	if playerPos.x < leftMostBuilding.x:
		return playerPos - Vector2(spawnOffset, 0)
	else:
		return leftMostBuilding - Vector2(spawnOffset, 0)

func get_right_spawn_position():
	var playerPos = Players.character.position
	if playerPos.x < rightMostBuilding.x:
		return playerPos + Vector2(spawnOffset, 0)
	else:
		return rightMostBuilding + Vector2(spawnOffset, 0)

func on_building_built(building: Node2D):
	if building.position.x < leftMostBuilding.x:
		leftMostBuilding = building.position
	elif building.position.x > rightMostBuilding.x:
		rightMostBuilding = building.position
