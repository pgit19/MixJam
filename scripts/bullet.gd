extends Area2D

var target_position : Vector2


func set_up(p_target_position : Vector2):
	target_position = p_target_position

func _physics_process(delta):
	var tween = create_tween()
