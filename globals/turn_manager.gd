extends Node

signal player_turn_started
signal enemy_turn_started
signal level_finished

var current_turn : Enums.Turn

func _ready():
	reset()

func start_game():
	current_turn = Enums.Turn.PLAYER
	player_turn_started.emit()

func reset():
	current_turn = Enums.Turn.PLAYER


func set_level_finished():
	print("Level finished")
	current_turn = Enums.Turn.PLAYER
	level_finished.emit()
	player_turn_started.emit()


func end_turn():
	match current_turn:
		Enums.Turn.PLAYER:
			current_turn = Enums.Turn.ENEMY
			enemy_turn_started.emit()
		Enums.Turn.ENEMY:
			current_turn = Enums.Turn.PLAYER
			player_turn_started.emit()
