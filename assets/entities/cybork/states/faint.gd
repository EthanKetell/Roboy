extends State

var waking

func on_enter():
	host.anim.play("faint")
	waking = false
	host.set_collision_layer_bit(2, false)
	yield(host.anim, "animation_finished")
	host.set_collision_layer_bit(3, true)

func update(delta):
	if host.repaired and not waking:
		host.anim.play("wake")
		waking = true

func get_transition():
	if waking and !host.anim.is_playing():
		return "idle_walk"
