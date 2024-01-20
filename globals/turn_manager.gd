extends Node

signal player_turn_started
signal enemy_turn_started

var current_turn : Enums.Turn

func _ready():
	current_turn = Enums.Turn.PLAYER


func end_turn():
	match current_turn:
		Enums.Turn.PLAYER:
			current_turn = Enums.Turn.ENEMY
			enemy_turn_started.emit()
		Enums.Turn.ENEMY:
			current_turn = Enums.Turn.PLAYER
			player_turn_started.emit()
