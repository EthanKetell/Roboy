extends State

func on_enter():
	host.anim.play("idle")

func update(delta):
	host.accelerate(0, 10*delta)
	if Input.is_action_just_pressed("move_jump"):
		host.jump()

func get_transition():
	if not host.is_on_floor():
		return "in_air"
	if Input.is_action_just_pressed("attack"):
		return "attack"
	if Input.is_action_just_pressed("grapple"):
		return "grapple"
	if host.input.x:
		return "move"
