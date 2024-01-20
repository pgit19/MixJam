class_name Shot extends Node2D

@onready var crosshair_sprite : Sprite2D = $CrosshairSprite

var direction : Vector2
var current_target_position : Vector2
var crosshair_move_speed : float = 300


func set_up(p_position : Vector2, p_direction : Vector2, p_signal_host : Character):
	position = p_position
	direction = p_direction
	p_signal_host.shot_released.connect(_on_shot_released, 4)


func _ready():
	pass


func _physics_process(delta):
	move_target_position_along_direction(delta)
	set_crosshair_sprite_to_target_position()


func move_target_position_along_direction(delta : float):
	current_target_position += direction * crosshair_move_speed * delta


func set_crosshair_sprite_to_target_position():
	crosshair_sprite.set_position(current_target_position)


func _on_shot_released():
	print("Release")
	queue_free()
