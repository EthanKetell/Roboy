extends State

export var recoil_force = 500

func on_enter():
	host.anim.play("recoil")
	host.velocity.x = recoil_force if host.flip_h else -recoil_force

func update(delta):
	host.accelerate(0, 10*delta)
	host.velocity.y += host.gravity*delta
	
func get_transition():
	if abs(host.velocity.x) < 10:
		return "idle"
