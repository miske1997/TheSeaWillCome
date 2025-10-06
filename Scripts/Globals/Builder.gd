extends Node

var prefabAdresses: Dictionary[String, String] = {}

func build_prefab(prefabName: String) -> Node2D:
	if not prefabAdresses.has(prefabName):
		return null
	var prefab = load(prefabAdresses[prefabName]).instantiate()
	return prefab

func makeEnemy(enemyName: String) -> Node2D:
	var enemy := build_prefab(enemyName)
	return enemy

func makeBuilding(buildingName: String, materials: Resources) -> Node2D:
	Utils.payResources(materials)
	var building := build_prefab(buildingName)
	Events.buildingBuilt.emit(building)
	return building
