class_name Shot extends Node2D

@onready var crosshair_sprite : Sprite2D = $CrosshairSprite

var direction : Vector2
var current_target_position : Vector2
var crosshair_move_speed : float = 500

const max_shot_distance = 2000
const crosshair_acceleration_factor = 1.03


func set_up(p_signal_host : Character, p_direction : Vector2):
	position = p_signal_host.position
	direction = p_direction
	p_signal_host.shot_released.connect(_on_shot_released, 4)



func _physics_process(delta):
	move_target_position_along_direction(delta)
	set_crosshair_sprite_to_target_position()
	if position.distance_to(current_target_position + position) >= max_shot_distance:
		_on_shot_released()


func move_target_position_along_direction(delta : float):
	crosshair_move_speed *= crosshair_acceleration_factor
	current_target_position += direction * crosshair_move_speed * delta


func set_crosshair_sprite_to_target_position():
	crosshair_sprite.set_position(current_target_position)


func instantiate_bullet():
	var bullet_instance = Preloads.bullet_scene.instantiate()
	bullet_instance.set_up(position, position + current_target_position)
	get_parent().add_child(bullet_instance)
	

func _on_shot_released():
	instantiate_bullet()
	queue_free()
