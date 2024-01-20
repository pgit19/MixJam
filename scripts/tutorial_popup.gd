extends Control

signal ok_button_pressed

@onready var ok_button = $CanvasLayer/PanelContainer/HBoxContainer/MarginContainer/TextureButton

func _ready():
	ok_button.pressed.connect(_on_ok_button_pressed)


func _on_ok_button_pressed():
	Utils.show_tutorial = false
	ok_button_pressed.emit()
	queue_free()
