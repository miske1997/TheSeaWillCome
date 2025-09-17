class_name Interactible extends Node2D

@export var interactDistance: float = 10.0
var inRange := false
var active = true
var selected := false

signal interacted


func _process(delta: float) -> void:
	if not active:
		return
	if Input.is_action_just_pressed("Interact"):
		interacted.emit()
