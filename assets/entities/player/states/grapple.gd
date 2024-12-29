extends State

export var reel_speed = 1500

func on_enter():
	host.flip_h = host.get_global_mouse_position().x < host.global_position.x
	host.grapple_arm.active = true
	if host.is_on_floor():
		host.anim.play("grapple_windup")
		yield(host.anim, "animation_finished")
		host.anim.play("grapple_ground")
	else:
		host.anim.play("grapple_air")
	host.grapple()

func update(delta):
	if host.grapple_arm.connected:
		if host.is_on_floor():
			host.anim.play("grapple_ground")
		else:
			host.anim.play("grapple_air")
		if host.grapple_arm.global_position.distance_to(host.grapple_arm.hand.global_position) < 150:
			host.grapple_arm.reset()
		else:
			host.velocity = host.grapple_arm.global_position.direction_to(host.grapple_arm.hand.global_position) * reel_speed
	else:
		if host.is_on_floor():
			host.accelerate(0, 10*delta)
		else:
			host.velocity.y += host.gravity*delta
			host.accelerate(host.input.x*host.run_speed, delta)

func get_transition():
	if not host.grapple_arm.active or Input.is_action_just_pressed("move_jump"):
		if host.is_on_floor():
			return "idle"
		else:
			return "in_air"

func on_exit():
	if host.grapple_arm.active:
		host.grapple_arm.reset()
