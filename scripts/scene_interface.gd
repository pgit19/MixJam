class_name SceneInterface extends Node

signal scene_change_requested


func request_scene_change(p_scene_interface_type : Enums.SceneInterfaceType):
	scene_change_requested.emit(p_scene_interface_type)
