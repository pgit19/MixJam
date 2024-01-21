extends Node2D

@onready var player = get_parent().get_parent().get_parent().get_node("Player")


func _ready():
	TurnManager.enemy_turn_started.connect(_on_turn_started)
	
 
func get_player_position():
	if player:
		return player.position
	else:
		return Vector2.ZERO


func _on_turn_started():
	print("Enemy Turn Started")
	#TODO: Enemy turn
	await get_tree().create_timer(1).timeout
	print("Enemy turn ended")
	TurnManager.end_turn()
