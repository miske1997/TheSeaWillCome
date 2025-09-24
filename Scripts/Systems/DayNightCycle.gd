extends Node

@export var tick: float = 10.0
@export var gameTotalTime: int = 3600
@export var timeIncrement: int = 10

func _ready() -> void:
	$Timer.wait_time = tick

func increment_time() -> void:
	GameData.gameTime += timeIncrement
	if GameData.gameTime > gameTotalTime / 2.0 and not GameData.nightTime:
		Events.nightFall.emit()
	GameData.nightTime = GameData.gameTime > gameTotalTime / 2.0
	GameData.gameTime %= gameTotalTime
	
	
