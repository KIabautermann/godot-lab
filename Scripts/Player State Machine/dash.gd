extends State

var start_position
var start_time
var recovery = false
var end = false

func enter() -> void:
	parent.animations["parameters/conditions/dashEnd"] = false
	parent.animations["parameters/conditions/dash"] = true
	start_position = parent.global_position.x
	start_time = Time.get_ticks_msec()
	parent.velocity.y = 0
	parent.velocity.x = values.dash_velocity * parent.facing_direction
	recovery = false;
	end = false
	parent.timer.wait_time = stats.dash_time
	parent.timer.start()
	

func exit() -> void:
	pass
	
func process_frame (delta: float) -> State:
	super(delta)
	return null
	
func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null
	

func exit_check() -> State:
	if parent.is_on_floor():
		return states.idle if axis_x == 0 else states.move
	return states.fall


func _on_timer_timeout():
	if(recovery):
		##print_debug("Time Elapsed: ", Time.get_ticks_msec()-start_time, " ms")
		##print_debug("Distance: ", parent.global_position.x-start_position, " px")
		print_debug(exit_check())
		my_state_machine.change_state(exit_check())
		parent.animations["parameters/conditions/dashEnd"] = true
		parent.animations["parameters/conditions/dash"] = false
	else:
		parent.velocity.x = values.dash_recovery_velocity * parent.facing_direction
		recovery = true
		parent.timer.wait_time = stats.dash_recovery_time
		parent.timer.start()
