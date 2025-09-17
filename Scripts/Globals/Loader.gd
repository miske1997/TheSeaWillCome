extends Node

func _ready() -> void:
	load_global_scene()
	load_adresses()
	init_player_data()
	
func init_player_data() -> void:
	Players._resourceData = preload("res://Data/resources.tres")
	
func load_adresses() -> void:
	LevelLoader.levelAdresses = load_addresses("res://Scenes/Levels/")
	Builder.prefabAdresses = load_addresses("res://Prefabs/")
	SoundSystem.soundAdresses = load_addresses("res://Assets/Sounds/")

func load_global_scene() -> void:
	var globalScene := preload("res://Scenes/global_scene.tscn").instantiate()
	for i in 10:
		await get_tree().process_frame
	get_tree().root.add_child(globalScene)

func load_addresses(startPath: String) -> Dictionary[String, String]:
	var adresses: Dictionary[String, String] = {}
	
	for file: String in DirAccess.get_files_at(startPath):
		adresses.set(file.split(".tscn")[0], startPath + file.split(".remap")[0])
	for dir in DirAccess.get_directories_at(startPath):
		adresses.merge(load_addresses(startPath + dir + "/"))
	return adresses
