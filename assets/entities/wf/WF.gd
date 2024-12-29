extends StaticBody2D

var head_turned = false
var duration
var anim = 0

func _ready():
	duration = rand_range(0.5, 3)

func _process(delta):
	duration -= delta
	if duration <= 0:
		pick_random_anim()
		duration = rand_range(0.5, 3)

func pick_random_anim():
	if head_turned:
		anim = randi()%2
		if anim == 0:
			$AnimationPlayer.play("head_turn_back")
			head_turned = false
		else:
			$AnimationPlayer.play("turn_tail")
	else:
		anim = randi()%3
		if anim == 0:
			$AnimationPlayer.play("ear_flick")
		elif anim == 1:
			$AnimationPlayer.play("head_turn")
			head_turned = true
		elif anim == 2:
			$AnimationPlayer.play("tail_back")
	yield($AnimationPlayer, "animation_finished")
