extends Node2D

signal player_finished_level


func _ready():
	determine_level(LevelManager.current_level)


func determine_level(p_level : Enums.Level):
	match p_level:
		Enums.Level.ONE:
			set_up_level(Preloads.level_1_scene)
		Enums.Level.TWO:
			set_up_level(Preloads.level_2_scene)
		Enums.Level.THREE:
			set_up_level(Preloads.level_3_scene)


func set_up_level(p_level_scene : PackedScene):
	var level_instance : Level = p_level_scene.instantiate()
	level_instance.player_finished_level.connect(func(): player_finished_level.emit())
	add_child(level_instance)


