extends Control



func _ready():
	PlayerStats.health_changed.connect(_on_player_health_changed)


func _on_player_health_changed(p_new_value : float):
	$HealthBar.set_value(p_new_value)
