extends State

var start_position
var start_time
var dash_step = 0
var direction : Vector2
@onready var line : Line2D = $"../../../Line2D"
var trail = preload("res://prefabs/dash_trail.tscn")


func enter() -> void:
	direction = Vector2 (Input.get_axis("axis_left","axis_right") ,Input.get_axis("axis_up","axis_down"))
	parent.animations["parameters/conditions/dash"] = true
	parent.animations["parameters/conditions/dash_end"] = false
	if direction.length() == 0: direction.x = parent.facing_direction
	parent.animations["parameters/dash/blend_position"] = direction
	start_position = parent.global_position
	start_time = Time.get_ticks_msec()
	dash_step = 0
	parent.timer.wait_time = stats.dash_startup
	parent.timer.start()
	line.reparent($"../../../..")
	line.width = 3
	

func exit() -> void:
	pass
	
func process_frame (delta: float) -> State:
	super(delta)
	if dash_step > 0: line.add_point(parent.global_position - start_position)
	return null
	
func process_physics(delta: float) -> State:
	if dash_step == 1:
		var instance = trail.instantiate()
		instance.position = parent.global_position
		instance.rotation = (Vector2(parent.facing_direction,0).angle_to(direction))
		add_child(instance)
	parent.move_and_slide()
	return null
	

func exit_check() -> State:
	if parent.is_on_floor():
		return states.idle if axis.x == 0 else states.move
	return states.fall


func _on_timer_timeout():
	if dash_step == 0:
		dash_step += 1
		parent.velocity.y = 0
		parent.velocity = values.dash_velocity * direction.normalized()
		parent.timer.wait_time = stats.dash_time
		parent.sprite.hide()
		parent.timer.start()
	
	elif dash_step == 1:
		parent.sprite.show()
		if direction.y == 1:
			parent.velocity.x = values.dash_recovery_velocity * direction.normalized().x	
			parent.velocity.y = stats.exit_fall_velocity
		else:	
			parent.velocity = values.dash_recovery_velocity * direction.normalized()
		dash_step += 1
		parent.timer.wait_time = stats.dash_recovery_time
		parent.timer.start()
		line.width = 1
	
	else:
		##print_debug("Time Elapsed: ", Time.get_ticks_msec()-start_time, " ms")
		##print_debug("Distance: ", parent.global_position.x-start_position, " px")
		line.reparent($"../../..")
		line.clear_points()
		line.position = Vector2(0,0)
		parent.animations["parameters/conditions/dash"] = false
		parent.animations["parameters/conditions/dash_end"] = true
		my_state_machine.change_state(exit_check())
