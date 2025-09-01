extends Node

var prefabAdresses: Dictionary[String, String] = {}

func build_prefab(prefabName: String) -> Node2D:
	if not prefabAdresses.has(prefabName):
		return null
	var prefab = load(prefabAdresses[prefabName]).instantiate()
	return prefab
