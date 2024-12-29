class_name Player
extends KinematicBody2D

onready var sprite := $Sprite
onready var anim := $Sprite/AnimationPlayer
onready var grapple_arm := $grapple_arm
onready var attack_area := $attack_area
onready var label := $Label
onready var state_machine := $state_machine

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
var velocity := Vector2()
var input := Vector2()
var move_snap = Vector2.DOWN*5
var interact_target = null setget set_interact_target

func set_interact_target(val, exited=false):
	print(val)
	interact_target = null if exited else val
	if interact_target:
		label.set_text(InputMap.get_action_list("interact")[0].as_text() + ": " + interact_target.prompt)
	else:
		label.set_text("")

var flip_h = false setget set_flip_h
func set_flip_h(val):
	flip_h = val
	sprite.flip_h = val
	$flip_h_remotes.scale.x = -1 if val else 1

export var walk_speed = 400
export var run_speed = 750
export var jump_height = 256
export (NodePath) var drone_path
onready var drone = get_node(drone_path)

func _unhandled_input(event):
	if event.is_action_pressed("interact") and interact_target:
		drone.repair(interact_target)

func _physics_process(delta):
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	velocity = move_and_slide_with_snap(velocity, move_snap, Vector2.UP)

func accelerate(speed, factor):
	velocity.x = lerp(velocity.x, speed, factor)

func jump(height = jump_height):
	velocity.y = -sqrt(2*gravity*jump_height)

func attack():
	var bodies = attack_area.get_overlapping_bodies()
	for body in bodies:
		body.hurt(self)

func grapple():
	grapple_arm.fire()

func hurt(source):
	self.flip_h = source.position.x < self.position.x
	state_machine.enter_state("recoil")
