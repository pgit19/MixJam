extends Node2D


func _ready():
	TurnManager.enemy_turn_started.connect(_on_turn_started)
	

func _on_turn_started():
	print("Enemy Turn Started")
	#TODO: Enemy turn
	await get_tree().create_timer(1).timeout
	print("Enemy turn ended")
	TurnManager.end_turn()
