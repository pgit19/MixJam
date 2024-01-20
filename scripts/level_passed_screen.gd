extends SceneInterface


@onready var next_level_button = $CanvasLayer/MarginContainer/VBoxContainer/NextLevelButton
@onready var back_to_menu_button = $CanvasLayer/MarginContainer/VBoxContainer/BackToMenuButton
@onready var quit_button = $CanvasLayer/MarginContainer/VBoxContainer/QuitButton


func _ready():
	next_level_button.pressed.connect(_on_next_level_button_pressed)
	back_to_menu_button.pressed.connect(_on_back_to_menu_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	

func _on_next_level_button_pressed():
	LevelManager.current_level += 1


func _on_back_to_menu_button_pressed():
	request_scene_change(Enums.SceneInterfaceType.MENU)


func _on_quit_button_pressed():
	get_tree().quit()
