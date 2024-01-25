extends State

var jump_buffer_timer: float = 0
var coyote_timer: float = 0

var peak = true

func enter() -> void:
	super()
	peak = true
	jump_buffer_timer = 0
	if parent.jumps_left == stats.jumps:
		coyote_timer = stats.coyote_time
		parent.jumps_left -= 1
	else:
		coyote_timer = 0
	
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump'):
		if coyote_timer > 0 || parent.jumps_left > 0:
			return states.jump
		jump_buffer_timer = stats.jump_buffer_time
	if Input.is_action_just_pressed('dash'):
		return states.dash
	return null
	
func process_frame (delta: float) -> State:
	super(delta)
	if axis_x != 0: parent.flip(axis_x)
	return null
	
func process_physics(delta: float) -> State:
	jump_buffer_timer -= delta
	coyote_timer -= delta
	var grav_mult = stats.peak_multiplier if parent.velocity.y < stats.treshold else stats.fall_multiplier
	parent.velocity.y += values.regular_gravity * grav_mult * delta

	
	if axis_x != 0:
		parent._movementX(axis_x, stats.movement_speed, values.air_acceleration, delta)
	else:
		parent._movementX(axis_x, 0, values.air_deceleration, delta)
	
	if parent.is_on_floor():
		if jump_buffer_timer > 0:
			return states.jump
		parent.jumps_left = stats.jumps
		parent.animations["parameters/basicMovement/1/conditions/land"] = true
		if axis_x != 0:
			return states.move
		return states.idle
	return null
