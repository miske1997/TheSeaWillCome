extends Node


func SaveGame() -> void:
	CheckFolder()
	if not GameData.saveData:
		GameData.saveData = SaveData.new()

	GameData.saveData.levelStack = LevelLoader.levelStack.map(func(level) -> String: return level.name)
	ResourceSaver.save(GameData.saveData, "user://Saves/" + GameData.slotInUse + ".tres")

func CheckFolder() -> void:
	if not DirAccess.dir_exists_absolute(OS.get_user_data_dir() + "/Saves"):
		DirAccess.make_dir_absolute(OS.get_user_data_dir() + "/Saves")
