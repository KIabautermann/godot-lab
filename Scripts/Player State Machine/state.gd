class_name State
extends Node

var stats : PlayerStats
var values : PrecalculatedValues
var states : StateContainer
var axis : Vector2
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
	axis = Vector2 (Input.get_axis("axis_left","axis_right") ,Input.get_axis("axis_up","axis_down"))
	parent.UI.text = str(axis)
	parent.UI.global_position = parent.UI.pos + axis.normalized() * 10
	return null

func process_physics(delta: float) -> State:
	return null
