extends Node
class_name StateMachine

onready var host = get_parent()

export var default_state:String
var states = {}
var state

func _ready():
	for child in get_children():
		if child is State:
			child.host = host
			states[child.name] = child
	call_deferred("enter_state", default_state)

func enter_state(new_state):
	if state: state.on_exit()
	state = states[new_state]
	state.on_enter()

func _physics_process(delta):
	if not state: return
	state.update(delta)
	var new_state = state.get_transition()
	if new_state: enter_state(new_state)

func _unhandled_input(event):
	if state: state.input(event)
