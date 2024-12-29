extends State

export var chase_speed = 400

func on_enter():
	host.anim.play("run")

func update(delta):
	host.flip_h = host.target.position.x > host.position.x
	host.move_and_slide_with_snap(Vector2(chase_speed if host.flip_h else -chase_speed, 0), Vector2.DOWN*100, Vector2.UP)
	
func get_transition():
	if host.attack_target:
		return "attack"
