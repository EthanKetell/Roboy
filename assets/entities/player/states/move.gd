extends State

func on_enter():
	host.anim.play("walk")

func update(delta):
	var run = Input.is_action_pressed("move_sprint")
	host.accelerate(host.input.x*(host.run_speed if run else host.walk_speed), 5*delta)

	if host.input.x:
		host.flip_h = host.input.x < 0

	if run:
		host.anim.play("run")
	else:
		host.anim.play("walk")

	if Input.is_action_just_pressed("move_jump"):
		host.jump()

func get_transition():
	if not host.is_on_floor():
		return "in_air"
	if Input.is_action_just_pressed("attack"):
		return "attack"
	if Input.is_action_just_pressed("grapple"):
		return "grapple"
	if not host.input.x:
		return "idle"
