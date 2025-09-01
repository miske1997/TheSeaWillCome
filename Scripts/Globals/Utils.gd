extends Node


func get_node_in_group_scope(scope: Node, group: String):
	for node in get_tree().get_nodes_in_group(group):
		if scope.is_ancestor_of(node):
			return node
	return null
