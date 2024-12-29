extends State

var duration
export var walk_speed = 200

func on_enter():
	host.anim.play("blue_walk" if host.repaired else "walk")
	if host.ground_check.is_colliding() and not host.is_on_wall():
		host.flip_h = randi()&1
	else:
		host.flip_h = !host.flip_h
	duration = rand_range(0.5, 3)
	walk_speed = abs(walk_speed) * (1 if host.flip_h else -1)

func update(delta):
	host.move_and_slide_with_snap(Vector2(walk_speed, 0), Vector2.DOWN*100, Vector2.UP)
	duration -= delta

func get_transition():
	if host.target and not host.repaired:
		return "chase"
	if duration <= 0 or not host.ground_check.is_colliding() or host.is_on_wall():
		return "idle"
	
