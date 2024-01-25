extends State


func enter() -> void:
	super()
	parent.animations["parameters/basicMovement/1/grounded/blend_position"] = 0
	
func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return states.jump
	if Input.is_action_just_pressed('dash') and parent.is_on_floor():
		return states.dash
	if Input.is_action_pressed("axis_left") || Input.is_action_pressed("axis_right"):
		return states.move
	return null
	


func process_physics(delta: float) -> State:
	parent.velocity.y += values.regular_gravity * delta
	parent._movementX(0, 0, values.ground_deceleration, delta)
	if !parent.is_on_floor():
		return states.fall
	return null
