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
	if get_child_count() == 0:
		TurnManager.set_level_finished()
	else:
		for i in get_children():
			i.shoot()
			await get_tree().create_timer(0.5).timeout
		await get_tree().create_timer(2).timeout
		TurnManager.end_turn()
