extends Node

onready var player := $Player

export(PackedScene) var start_level
var level

func _ready():
	load_level(start_level)

func load_level(new_level):
	if level: level.queue_free()

