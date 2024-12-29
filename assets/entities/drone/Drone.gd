extends Sprite

signal repair_finished

const repair_material = preload("res://assets/entities/drone/repair.material")
export(float, 0, 1) var repair_effect_amount = 0 setget set_repair_effect_amount
func set_repair_effect_amount(val):
	repair_effect_amount = val
	repair_material.set_shader_param("amount", val)

export var follow_height = 224
export var repair_height = 50

export(NodePath) var target_path
onready var target:Node2D = get_node(target_path)

onready var anim := $AnimationPlayer
onready var follow_offset = $follow_offset.position

func _ready():
	global_position = target.global_position-follow_offset

func _physics_process(delta):
	flip_h = global_position.x > target.global_position.x

	var pos = global_position
	var target_pos = target.global_position
	target_pos.y -= follow_offset.y
	target_pos.x = clamp(global_position.x, target.global_position.x - follow_offset.x, target.global_position.x + follow_offset.x)
	global_position = lerp(global_position, target_pos, 0.05)
	var change = pos-global_position

	change.y += 10
	change = change.rotated(-PI/2)
	var new_rotation = clamp(change.angle(), -PI/4, PI/4)
	rotation = lerp(rotation, new_rotation, 0.1)

func repair(object):
	var old_target = target
	follow_offset.y = repair_height
	self.target = object
	target.material = repair_material
	target.start_repair()
	yield(get_tree().create_timer(2), "timeout")
	anim.play("scan_start")
	yield(get_tree().create_timer(2), "timeout")
	anim.play("scan_end")
	object.finish_repair()
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("repair_finished")
	target.material = null
	target = old_target
	follow_offset.y = follow_height
