class_name Level extends Node2D

signal player_finished_level

@onready var finish_area = $FinishArea

func _ready():
	finish_area.body_entered.connect(_on_finish_area_body_entered)


func _on_finish_area_body_entered(p_body : Character):
	if p_body is Player:
		player_finished_level.emit()
