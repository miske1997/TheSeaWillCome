extends Node

@export var tick: float = 10.0
@export var gameTotalTime: int = 3600
@export var timeIncrement: int = 10

func _ready() -> void:
	$Timer.wait_time = tick

func increment_time() -> void:
	GameData.gameTime += timeIncrement
	GameData.gameTime = GameData.gameTime % gameTotalTime
	GameData.nightTime = GameData.gameTime > gameTotalTime / 2
