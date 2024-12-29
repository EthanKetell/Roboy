extends KinematicBody2D

const prompt = "Rescue"
const Laser = preload("res://assets/entities/doggo/Laser.tscn")

export var thrust_gs = 3

var velocity := Vector2()
var flip_h := false setget set_flip_h
var target = null
var attack_target = null
var health = 3
var repaired = false

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var _flip_h_remotes := $flip_h_remotes
onready var sprite := $Sprite
onready var anim := $AnimationPlayer
onready var ground_check := $ground_check
onready var wall_check := $wall_check
onready var drop_off_check := $drop_off_check
onready var state_machine := $StateMachine
onready var laser_source := $flip_h_remotes/laser_source

# warning-ignore:unused_argument
func _physics_process(delta):
	velocity = move_and_slide(velocity)

func set_flip_h(val):
	if flip_h != bool(val):
		flip_h = val
		sprite.flip_h = flip_h
		_flip_h_remotes.scale.x *= -1
		wall_check.cast_to.x *= -1

func _on_body_entered_detection_area(body):
	if body is Player:
		target = body

func attack():
	if attack_target:
		var laser = Laser.instance()
		laser.init(self, laser_source.global_position.direction_to(attack_target.global_position))
		laser.position = laser_source.global_position
		get_tree().current_scene.add_child(laser)

func start_repair():
	self.set_collision_layer_bit(3, false)

func finish_repair():
	repaired = true

func hurt(source):
	self.flip_h = source.position.x > self.position.x
	state_machine.enter_state("recoil")
	health -= 1
