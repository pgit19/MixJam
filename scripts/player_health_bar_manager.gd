extends Control

@onready var health_bar = $HealthBar

func _ready():
	PlayerStats.health_changed.connect(_on_health_changed)
	health_bar.set_max(PlayerStats.max_health)
	
func _on_health_changed(p_health : float):
	health_bar.set_value(p_health)
