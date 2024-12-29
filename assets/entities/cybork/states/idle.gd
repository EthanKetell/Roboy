extends State

var duration

func on_enter():
	host.anim.play("blue_idle" if host.repaired else "idle")
	duration = rand_range(0.5, 3)

func update(delta):
	duration -= delta
	
func get_transition():
	if host.target and not host.repaired:
		return "chase"
	if duration <= 0:
		return "idle_walk"
