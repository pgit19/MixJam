extends SceneInterface

@onready var player = $Player

func _ready():
	PlayerStats.health_changed.connect(_on_player_health_changed)
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
