extends Control

@onready var fuel_bar = $HBoxContainer/FuelBar

func _ready():
	PlayerStats.fuel_changed.connect(_on_player_fuel_changed)


func _on_player_fuel_changed(p_new_value : float):
	fuel_bar.set_value(p_new_value)
