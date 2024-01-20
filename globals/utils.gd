extends Node2D

var show_tutorial : bool = true:
	set(p_show_tutorial):
		show_tutorial = p_show_tutorial
	get:
		return show_tutorial


func get_mouse_direction_relative_to_position(p_position : Vector2) -> Vector2:
	return (get_global_mouse_position() - p_position).normalized()
