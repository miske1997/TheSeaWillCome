extends Node

var mainMenuScene: PackedScene = preload("res://Scenes/UI/main_menu.tscn")
var levelAdresses: Dictionary[String, String] = {}
var levelStack: Array[Node] = []

var levelDic: Dictionary[String, Node2D] = {}

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
	var level: Node = levelDic[levelName]
	levelStack.push_back(level)
	get_tree().root.add_child(level)
	level.focus()
	return true
	
func pop_level() -> void:
	if levelStack.is_empty():
		return
	var currentLevel: Node = levelStack.pop_back()
	currentLevel.un_focus()

func pre_load_levels():
	var levelStep = 5000
	for i in 2:
		var level: Level = load("res://Scenes/Levels/cave_level_" + str(i + 1) + ".tscn").instantiate()
		level.position = Vector2(0, (i + 1) * levelStep)
		level.init()
		level.un_focus()
		get_tree().root.add_child(level)
		levelDic.set("cave_level_" + str(i + 1), level)
		
	
