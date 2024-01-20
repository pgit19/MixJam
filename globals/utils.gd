extends Node2D


func get_mouse_direction_relative_to_position(p_position : Vector2) -> Vector2:
	return (p_position - get_global_mouse_position()).normalized() * -1
