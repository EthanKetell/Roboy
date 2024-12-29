extends State

func on_enter():
	if host.velocity.y < 0:
		host.anim.play("jump")
	else:
		host.anim.play("fall")

func update(delta):
	host.velocity.y += host.gravity*delta
	host.accelerate(host.input.x*host.run_speed, delta)
	if host.velocity.y < 0:
		host.anim.play("jump")
	else:
		host.anim.play("fall")

func get_transition():
	if host.is_on_floor():
		if host.input.x:
			return "move"
		else:
			return "idle"
	if Input.is_action_just_pressed("grapple"):
		return "grapple"
