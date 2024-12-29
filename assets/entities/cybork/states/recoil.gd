extends State

export var knockback_amount = 500
export var max_duration = 0.5
var duration

func on_enter():
	host.anim.play("recoil")
	knockback_amount = abs(knockback_amount) * (-1 if host.flip_h else 1)
	duration = 0

func update(delta):
	host.move_and_slide_with_snap(Vector2(lerp(knockback_amount, 0, duration/max_duration), 0), Vector2.DOWN*100, Vector2.UP)
	duration += delta
	
func get_transition():
	if duration >= max_duration:
		if host.health <= 0:
			return "faint"
		else:
			return "chase"
