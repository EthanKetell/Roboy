extends State

var duration

func on_enter():
	host.anim.play("blue_idle" if host.repaired else "red_idle")
	duration = rand_range(0.5, 3)
	
func update(delta):
	host.velocity.y += host.gravity * delta
	if host.ground_check.is_colliding():
		host.velocity.y -= host.thrust_gs * host.gravity * delta
	host.velocity *= (1 - 1.5*delta)
	duration -= delta

func get_transition():
	if host.target and not host.repaired:
		return "chase"
	if duration <= 0:
		return "idle_roam"
