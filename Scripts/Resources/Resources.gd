class_name Resources extends Resource

signal resourceChanged

@export var resources : Dictionary[String, ResourceData]

func set_resource_amount(name: String, newAmount: int) -> void:
	if not resources.has(name):
		return
	resources[name].amount = newAmount
	resourceChanged.emit(name)
