extends State

export var roam_speed = 200
var duration

func on_enter():
	host.anim.play("blue_idle" if host.repaired else "red_idle")
	duration = rand_range(0.5, 3)
	if host.drop_off_check.is_colliding() and not host.wall_check.is_colliding():
		host.flip_h = randi()&1
	else:
		host.flip_h = !host.flip_h
	roam_speed = abs(roam_speed) * (1 if host.flip_h else -1)
	
func update(delta):
	host.velocity.x += roam_speed * delta
	host.velocity.y += host.gravity * delta
	if host.ground_check.is_colliding():
		host.velocity.y -= host.thrust_gs * host.gravity * delta
	host.velocity *= (1 - delta)
	duration -= delta

func get_transition():
	if host.target and not host.repaired:
		return "chase"
	if duration <= 0 or host.wall_check.is_colliding() or not host.drop_off_check.is_colliding():
		return "idle"
