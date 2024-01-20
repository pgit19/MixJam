extends SceneInterface


@onready var play_button = $CanvasLayer/MarginContainer/VBoxContainer/PlayButton
@onready var quit_button = $CanvasLayer/MarginContainer/VBoxContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(func(): get_tree().quit())
	

func _on_play_button_pressed():
	request_scene_change(Enums.SceneInterfaceType.GAME)
	

