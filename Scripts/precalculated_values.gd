extends Node
class_name PrecalculatedValues

@export var stats : PlayerStats
@onready var ground_acceleration = stats.movement_speed/stats.ground_acceleration_time
@onready var ground_deceleration = stats.movement_speed/stats.ground_deceleration_time
@onready var air_acceleration = stats.movement_speed/stats.air_acceleration_time
@onready var air_deceleration = stats.movement_speed/stats.air_deceleration_time
@onready var regular_gravity = (stats.jump_height * 2 * stats.movement_speed ** 2) / (stats.jump_lenght ** 2)
@onready var short_hop_gravity = (stats.jump_min_height * 2 * stats.movement_speed ** 2) / (stats.jump_min_lenght ** 2)
@onready var jump_velocity = -(stats.jump_height * 2 * stats.movement_speed) / stats.jump_lenght
@onready var dash_velocity = stats.dash_distance/stats.dash_time
@onready var dash_recovery_velocity = stats.dash_recovery_distance/stats.dash_recovery_time



