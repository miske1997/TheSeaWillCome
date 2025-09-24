extends Node


func get_node_in_group_scope(scope: Node, group: String):
	for node in get_tree().get_nodes_in_group(group):
		if scope.is_ancestor_of(node):
			return node
	return null
	
func castleHasResources(resources: Resources) -> bool:
	for key: String in resources.resources:
		var resourceData: ResourceData = resources.resources[key]
		if not GameData.castleResources.has(resourceData.name) or GameData.castleResources[resourceData.name].amount < resourceData.amount:
			return false
	return true
	
func payResources(resources: Resources) -> void:
	for key: String in resources.resources:
		var resourceData: ResourceData = resources.resources[key]
		GameData._resourceData.set_resource_amount(resourceData.name, GameData.castleResources[key].amount - resourceData.amount)
