extends State
var check = false

func enter() -> void:
	super()
	parent.animations["parameters/basicMovement/1/grounded/blend_position"] = 1
	check = false
	
func exit() -> void:
	super()
	parent.animations["parameters/basicMovement/1/conditions/land"] = false

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return states.jump
	if Input.is_action_just_pressed('dash') and parent.is_on_floor():
		return states.dash
	if !Input.is_action_pressed("axis_left") and !Input.is_action_pressed("axis_right"):
		return states.idle
	return null

func process_frame (delta: float) -> State:
	super(delta)
	parent.flip(axis_x)
	return null	

func process_physics(delta: float) -> State:
	parent.velocity.y += values.regular_gravity * delta
	
	parent._movementX(axis_x, stats.movement_speed, values.ground_acceleration, delta)
	
	if !parent.is_on_floor():
		return states.fall
	return null
