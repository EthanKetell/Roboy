extends KinematicBody2D

const prompt = "Rescue"

var flip_h = false setget set_flip_h
var target = null
var attack_target = null
var health = 3
var repaired = false

onready var _flip_h_remotes := $flip_h_remotes
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var sprite := $Sprite
onready var anim := $AnimationPlayer
onready var ground_check := $ground_check
onready var state_machine := $StateMachine

func set_flip_h(val):
	flip_h = val
	sprite.flip_h = flip_h
	_flip_h_remotes.scale.x = -1 if flip_h else 1

func on_body_entered_detection_area(body):
	if body is Player:
		target = body

func attack():
	if attack_target:
		attack_target.hurt(self)

func start_repair():
	self.set_collision_layer_bit(3, false)

func finish_repair():
	repaired = true

func hurt(source):
	self.flip_h = source.position.x > self.position.x
	state_machine.enter_state("recoil")
	health -= 1
