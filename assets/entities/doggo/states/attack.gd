extends State

func on_enter():
	host.anim.play("attack")

func get_transition():
	if not host.attack_target:
		return "chase"
