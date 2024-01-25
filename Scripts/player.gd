class_name Player
extends CharacterBody2D

@onready var animations : AnimationTree = $AnimatedSprite2D/AnimationTree

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var state_machine = $StateMachine

@export var stats : PlayerStats

@export var values : PrecalculatedValues

@onready var timer : Timer = $Timer

#region Ceiling Rays
@export var left_outer_ray : RayCast2D

@export var left_inner_ray : RayCast2D

@export var right_outer_ray : RayCast2D

@export var right_inner_ray : RayCast2D
#endregion

var jumps_left = 0;

var facing_direction = 1;

var using_gravity : bool = true 

var current_velocity : Vector2




func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	animations["parameters/basicMovement/blend_position"] = 0 if is_on_floor() else 1
	animations["parameters/basicMovement/0/blend_position"] = 0 if velocity.y < 0 else 1
	
func _movementX(direction: float, speed: float, acceleration: float, delta: float):
	var current_direction = sign(velocity.x)
	var target_velocity = direction * speed
	var dif = target_velocity - velocity.x
	velocity.x += acceleration * sign(dif) * delta
	if sign(velocity.x) != current_direction and velocity.x != 0 and current_direction != 0:
		velocity.x = 0
	if abs(velocity.x) < 1: velocity.x = 0
	move_and_slide()
	
func jump_correction() -> int:
	
	var right = 1  if right_outer_ray.is_colliding() and !right_inner_ray.is_colliding()  else 0
	var left = 1  if left_outer_ray.is_colliding() and !left_inner_ray.is_colliding()  else 0
	return left-right
	
func flip(direction: int):
	sprite.flip_h = direction < 0
	facing_direction = direction

