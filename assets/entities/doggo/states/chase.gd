extends State

export var chase_speed = 300

func on_enter():
	host.anim.play("red_idle")

func update(delta):
	host.flip_h = host.target.position.x > host.position.x
	host.velocity.x += (chase_speed if host.flip_h else -chase_speed)*delta
	host.velocity.y += host.gravity * delta
	if host.ground_check.is_colliding():
		host.velocity.y -= host.thrust_gs * host.gravity * delta
	host.velocity *= (1 - delta)
	
func get_transition():
	if host.attack_target:
		return "attack"
