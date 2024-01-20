extends Control



func _ready():
	PlayerStats.fuel_changed.connect(_on_player_fuel_changed)


func _on_player_fuel_changed(p_new_value : float):
	$FuelBar.set_value(p_new_value)
