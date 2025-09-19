class_name Tool extends Node2D

@export var toolConfig: ToolConfig
var lookAtTaret: Vector2
var inUse = false
var onCooldown = false
var enabled = false

signal activate
signal secondary
