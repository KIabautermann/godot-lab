extends Resource
class_name PlayerStats

#region Movement
@export_group("Basic Movement")
@export var movement_speed : float
@export var ground_acceleration_time : float
@export var ground_deceleration_time : float
@export var air_acceleration_time : float
@export var air_deceleration_time : float
#endregion

#region Jump
@export_group("Jump")
@export var jumps : float
@export var jump_time : float
@export var jump_height : int
@export var jump_min_height : int
@export var jump_lenght : int
@export var jump_min_lenght : int
@export var peak_multiplier : float
@export var fall_multiplier : float
@export var treshold : float
@export var jump_buffer_time : float
@export var coyote_time : float
@export var jump_correction : float
#endregion

#region Dash
@export_group("Dash")
@export var dash_time : float
@export var dash_distance : int
@export var dash_recovery_time : float
@export var dash_recovery_distance : int
#endregion



