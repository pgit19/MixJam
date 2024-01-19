extends Node

signal health_changed

var max_health = 100

var health : float:
	set(p_health):
		health = clamp(p_health, 0, max_health)
		health_changed.emit(health)
	get:
		return health
