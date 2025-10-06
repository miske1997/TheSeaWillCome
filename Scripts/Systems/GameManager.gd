extends Node

func _ready() -> void:
	Events.dayBreak.connect(on_day_began)
	Events.nightFall.connect(on_night_began)
	
	
func on_day_began():
	hire_workers()

func hire_workers():
	var foodLeft = GameData.castleResources["Wheat"].amount
	var housingAvailable = GameData.castleResources["Housing"].amount
	var canHire = min(foodLeft, housingAvailable)
	if canHire == 0:
		return
	var newWorkers = randi_range(floori(canHire / 2), canHire)
	GameData.increment_resource_amount("Workers", newWorkers)
	GameData.decrement_resource_amount("Housing", newWorkers)

func on_night_began():
	spendResources()
	
func spendResources():
	GameData.decrement_resource_amount("Wheat", GameData.workers.size())
