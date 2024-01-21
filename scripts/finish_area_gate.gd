extends Node2D

var initial_position : Vector2
var open_speed = 2
var level_finished : bool = false

func _ready():
	TurnManager.level_finished.connect(func(): level_finished = true)
	initial_position = position


func _process(delta):
	if level_finished:
		open(delta)


func open(delta):
	position = position.lerp(initial_position + Vector2(0, -200), open_speed * delta)
