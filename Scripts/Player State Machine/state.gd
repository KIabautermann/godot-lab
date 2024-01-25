class_name State
extends Node

var stats : PlayerStats
var values : PrecalculatedValues
var states : StateContainer
var axis_x : int
var my_state_machine : state_machine

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	axis_x = Input.get_axis("axis_left","axis_right")
	return null

func process_physics(delta: float) -> State:
	return null