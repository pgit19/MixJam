class_name HealthBar extends Control

@export var ui_theme : Theme
@export var bar_color : Color
@export var diff_color : Color

@onready var health_progress_bar = $HealthProgressBar
@onready var delayed_progess_bar = $DelayedProgressBar

const delayed_progress_bar_speed_per_second : float = 2.5


func _ready():
	z_index = ZIndex.health_bar
	health_progress_bar.set_tint_progress(bar_color)
	delayed_progess_bar.set_tint_progress(diff_color)
	
	if ui_theme:
		theme = ui_theme


func _process(delta):
	var weight = min(delayed_progress_bar_speed_per_second * delta, 1.0)
	var current_value = delayed_progess_bar.get_value()
	var target_value = health_progress_bar.get_value()
	var new_value = lerpf(current_value, target_value, weight)
	delayed_progess_bar.set_value_no_signal(new_value)


func set_max(p_value : float):
	health_progress_bar.set_max(p_value)
	delayed_progess_bar.set_max(p_value)
	

func set_value(p_value : float):
	health_progress_bar.set_value_no_signal(p_value)
	
