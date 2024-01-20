extends Node

signal health_changed
signal fuel_changed


func _ready():
	CombatUtils.character_damaged.connect(_on_character_damaged)


func _on_character_damaged(p_damage : float, p_character : Character):
	if p_character is Player:
		health = max(health - p_damage, 0)


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
var rotation_speed : float = 5
