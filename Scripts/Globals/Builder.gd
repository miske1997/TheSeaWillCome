extends Node

var prefabAdresses: Dictionary[String, String] = {}

func build_prefab(prefabName: String) -> Node2D:
	if not prefabAdresses.has(prefabName):
		return null
	var prefab = load(prefabAdresses[prefabName]).instantiate()
	return prefab

func makeBuilding(buildingName: String, materials: Resources) -> Node2D:
	Utils.payResources(materials)
	return build_prefab(buildingName)
