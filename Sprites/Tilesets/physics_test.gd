extends Node2D


@export var speed : float
@export var acceleration_time : float
@export var hitbox : ShapeCast2D
@export var marker : ColorRect
var acceleration
var current_velocity : Vector2 = Vector2(0,0)
var max_bounces = 5
var skin_width = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	acceleration = speed/acceleration_time
	current_velocity = Vector2(0,0)


func _physics_process(delta):
	var current_acceleration = acceleration
	var x = Input.get_axis("ui_left", "ui_right")
	var y = Input.get_axis("ui_up", "ui_down")
	var target_velocity = Vector2(x,y) * speed
	var dif = target_velocity - current_velocity
	if(abs(current_velocity.length()) < 0.1 and abs(dif.length()) < 0.1): 
		current_velocity = Vector2(0,0)
		current_acceleration = 0
	current_velocity += current_acceleration * sign(dif) * delta
	var normalized_velocity = current_velocity.length() * current_velocity.normalized()
	position += current_velocity * delta + (0.5 * current_acceleration * delta * delta) * current_velocity.normalized()
	
	
func collide_and_slide(vel: Vector2, pos: Vector2, depht: int) -> Vector2:
	if(depht > max_bounces):
		return Vector2(0,0)
	var dist = vel.length()
	if hitbox.is_colliding():
		var snap: Vector2 = vel.normalized() * (abs(hitbox.get_collision_point(depht) - global_position))
		var left: Vector2 = vel - snap
		
		var mag = left.length()
		left = left.project(hitbox.get_collision_normal(depht)).normalized()
		left *= mag
		
		return snap + collide_and_slide(left, pos, depht+1)

	return vel
	
	
	
	
	
	
	
	
	
	
	
