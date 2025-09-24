extends Node

var mainMenuScene: PackedScene = preload("res://Scenes/UI/main_menu.tscn")
var levelAdresses: Dictionary[String, String] = {}
var levelStack: Array[Node] = []


func load_level_with_effects() -> void:
	pass

func back_to_main_menu() -> void:
	for level in levelStack:
		level.queue_free()
	levelStack.clear()
	var mainMenu = mainMenuScene.instantiate()
	get_tree().root.add_child(mainMenu)


func push_level(levelName) -> bool:
	if not levelAdresses.has(levelName):
		return false
	var level: Node = load(levelAdresses[levelName]).instantiate()
	levelStack.push_back(level)
	get_tree().root.add_child(level)
	level.focus()
	return true
	
func pop_level() -> void:
	if levelStack.is_empty():
		return
	var currentLevel: Node = levelStack.pop_back()
	currentLevel.un_focus()
	currentLevel.queue_free()
