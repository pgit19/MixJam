extends Node2D

func _ready():
	pass
	
func set_current_scene_interface(p_scene : SceneInterface):
	for i in get_children():
		i.queue_free()
	add_child(p_scene)
