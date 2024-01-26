extends State

@export
var left_detection_inner : RayCast2D
@export
var left_detection_outer : RayCast2D
@export
var right_detection_inner : RayCast2D
@export
var right_detection_outer : RayCast2D


var short_hop

var peak




func enter() -> void:
	super()
	parent.velocity.y = values.jump_velocity
	short_hop = false;
	peak = false
	parent.jumps_left -= 1

func process_input(event: InputEvent) -> State:
	if !Input.is_action_pressed('jump'):
		short_hop = true
	if Input.is_action_just_pressed('dash'):
		return states.dash
	return null

func process_frame (delta: float) -> State:
	super(delta)
	if axis.x != 0: parent.flip(axis.x)
	return null	

func process_physics(delta: float) -> State:
	
	var correction = parent.jump_correction() 
	if(correction != 0):
		parent.global_position.x += correction * stats.jump_correction

	peak = parent.velocity.y > -stats.treshold
	var grav_mult = stats.peak_multiplier if peak else 1
	var current_grav = values.short_hop_gravity if short_hop else values.regular_gravity
	parent.velocity.y += current_grav * delta * grav_mult
	
	var movement = Input.get_axis("axis_left","axis_right")
	
	if parent.velocity.y >= 0:
		return states.fall
	
	if axis.x != 0:
		parent._movementX(axis.x, stats.movement_speed, values.air_acceleration, delta)
	else:
		parent._movementX(axis.x, 0, values.air_deceleration, delta)
	
	if parent.is_on_floor():
		parent.animations["parameters/basicMovement/1/conditions/land"] = true
		parent.jumps_left = stats.jumps
		if movement != 0:
			return states.move
		return 
	
	return null
