extends Node

var soundAdresses: Dictionary[String, String] = {}
var audio2DScene := preload("res://Scenes/Components/audio_2d.tscn")

var maxClipsAtATime := 10
var currentlyPlaying := 0

func play_sound(soundName: String) -> void:
	if not soundAdresses.has(soundName):
		return
	if currentlyPlaying == maxClipsAtATime:
		return
	currentlyPlaying += 1
	var sound: AudioStream = load(soundAdresses[soundName])
	var audioPlayer := AudioStreamPlayer.new()
	audioPlayer.stream = sound
	get_tree().get_first_node_in_group("Temp").get_node("GlobalAudio").add_child(audioPlayer)
	audioPlayer.play()
	await audioPlayer.finished
	audioPlayer.queue_free()
	currentlyPlaying -= 1
	
func play_sound_at_position(soundName: String, position: Vector2) -> void:
	if not soundAdresses.has(soundName):
		return
	var audioPlayer: Audio2D= audio2DScene.instantiate()
	audioPlayer.soundPath = soundAdresses[soundName]
	audioPlayer.position = position
	get_tree().get_first_node_in_group("Temp").get_node("Audio").add_child(audioPlayer)
