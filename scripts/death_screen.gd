extends SceneInterface

@onready var try_again_button = $CanvasLayer/MarginContainer/VBoxContainer/TryAgainButton
@onready var back_to_menu_button = $CanvasLayer/MarginContainer/VBoxContainer/BackToMenuButtoon


func _ready():
	try_again_button.pressed.connect(_on_try_again_button_pressed)
	back_to_menu_button.pressed.connect(_on_back_to_menu_button_pressed)
	

func _on_try_again_button_pressed():
	request_scene_change(Enums.SceneInterfaceType.GAME)


func _on_back_to_menu_button_pressed():
	request_scene_change(Enums.SceneInterfaceType.MENU)
