class_name Audio2D extends AudioStreamPlayer2D

var soundPath: String

func _ready() -> void:
	var sound := load(soundPath)
	stream = sound
	play()
	await finished
	queue_free()
