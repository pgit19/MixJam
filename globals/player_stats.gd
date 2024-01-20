extends Node

signal health_changed
signal fuel_changed

var max_health = 100
var max_fuel = 100

#TODO Player Pos
var player_pos = Vector2(-10, -10)

var health : float:
	set(p_health):
		health = clamp(p_health, 0, max_health)
		health_changed.emit(health)
	get:
		return health


var fuel : float:
	set(p_fuel):
		fuel = clamp(p_fuel, 0, max_fuel)
		fuel_changed.emit(fuel)
	get:
		return fuel

var move_speed : float = 300
