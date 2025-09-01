extends Area2D

@export_placeholder("Enter Level Name") var nextLevelName: String

var triggerd = false

func _on_body_entered(body: Node2D) -> void:
	load_next_level()

func _on_area_entered(area: Area2D) -> void:
	load_next_level()

func load_next_level() -> void:
	if triggerd:
		return
	triggerd = true
	LevelLoader.pop_level()
	LevelLoader.push_level(nextLevelName)
