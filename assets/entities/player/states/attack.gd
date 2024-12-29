extends State

var attack_2

func on_enter():
	attack_2 = false
	host.anim.play("attack_1")

func update(delta):
	host.accelerate(0, 10*delta)

func input(event):
	if event.is_action_pressed("attack") and host.anim.get_queue().empty():
		if attack_2:
			host.anim.queue("attack_1")
		else:
			host.anim.queue("attack_2")
		attack_2 = not attack_2

func get_transition():
	if not host.anim.is_playing():
		return "idle"
