extends Node2D

func _ready():
	set_up_level(LevelManager.current_level)


func set_up_level(p_level : Enums.Level):
	match p_level:
		Enums.Level.ONE:
			update_level(Preloads.level_1_scene)
		Enums.Level.TWO:
			update_level(Preloads.level_2_scene)
		Enums.Level.THREE:
			update_level(Preloads.level_3_scene)


func update_level(p_level_scene : PackedScene):
	print("Added Level ", p_level_scene)
	for i in get_children():
		i.queue_free()
	var level_instance = p_level_scene.instantiate()
	add_child(level_instance)
