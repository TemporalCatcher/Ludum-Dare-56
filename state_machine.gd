class_name  StateMachine
extends Node2D
## This is an abstract version of State Machine.
## It is inteded to provide the structure to be overrided

## the current state of the machine
var state : State:
	get = get_state, set = transition_to
var states : Array[State] = []

func get_state() -> State:
	return state

## transitions the state to a new state
func transition_to(new_state : State) -> void:
	if state == null:
		state = new_state
		return
	if state.has_method(&"exit"):
		state.exit()
	state = new_state
	if state.has_method(&"enter"):
		state.enter()


func ordinal() -> int:
	return states.find(state)


## An abstract state class to represents a state for the FSM
class State extends RefCounted:
	signal to_state(state : int)
	signal to_state_special(state : int, dict: Dictionary)
	
