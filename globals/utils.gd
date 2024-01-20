extends Node2D


func get_mouse_direction_relative_to_position(p_position : Vector2) -> Vector2:
	return (get_global_mouse_position() - p_position).normalized()
