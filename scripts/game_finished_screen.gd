extends SceneInterface

@onready var quit_button = $CanvasLayer/MarginContainer/VBoxContainer/QuitButton

func _ready():
	quit_button.pressed.connect(func(): get_tree().quit())
