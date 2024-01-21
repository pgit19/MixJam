extends SceneInterface

@onready var player = $Player
@onready var level_container = $LevelContainer


func _ready():
	PlayerStats.health_changed.connect(_on_player_health_changed)
	var screen_on_level_finished
	if LevelManager.current_level == Enums.Level.THREE:
		screen_on_level_finished = Enums.SceneInterfaceType.GAME_FINISHED_SCREEN
	else:
		screen_on_level_finished = Enums.SceneInterfaceType.LEVEL_PASSED_SCREEN
	level_container.player_finished_level.connect(request_scene_change.bind(screen_on_level_finished))
	setup_tutorial_popup()


func _on_player_health_changed(p_health : float):
	if p_health == 0:
		request_scene_change(Enums.SceneInterfaceType.DEATH_SCREEN)


func setup_tutorial_popup():
	if Utils.show_tutorial:
		get_tree().paused = true
		var popup_tutorial_instance = Preloads.tutorial_popup_scene.instantiate()
		popup_tutorial_instance.ok_button_pressed.connect(func(): get_tree().paused = false)
		add_child(popup_tutorial_instance)
