extends Node2D

func _ready():
	set_current_scene_interface(Enums.SceneInterfaceType.MENU)

func set_current_scene_interface(p_scene_interface_type : Enums.SceneInterfaceType):
	for i in get_children():
		i.queue_free()
	match p_scene_interface_type:
		Enums.SceneInterfaceType.GAME:
			set_up_scene(Preloads.game_scene)
			TurnManager.reset()
		Enums.SceneInterfaceType.MENU:
			set_up_scene(Preloads.menu_scene)
		Enums.SceneInterfaceType.DEATH_SCREEN:
			set_up_scene(Preloads.death_screen_scene)
		Enums.SceneInterfaceType.LEVEL_PASSED_SCREEN:
			set_up_scene(Preloads.level_passed_scene)
		Enums.SceneInterfaceType.GAME_FINISHED_SCREEN:
			set_up_scene(Preloads.game_finished_scene)


func set_up_scene(p_scene : PackedScene):
	var scene_instance : SceneInterface = p_scene.instantiate()
	scene_instance.scene_change_requested.connect(set_current_scene_interface)
	add_child(scene_instance)
