extends Area2D

signal activated
const prompt = "Repair Switch"

func _ready():
	print("hello")

func finish_repair():
	$AnimationPlayer.play("change")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("activated")
	
func start_repair():
	$CollisionShape2D.disabled = true
