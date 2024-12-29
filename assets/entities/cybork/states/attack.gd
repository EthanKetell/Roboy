extends State

func on_enter():
	host.anim.play("attack")

func get_transition():
	if not host.anim.is_playing():
		return "chase"
