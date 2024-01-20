extends Character

@export var min_distance: float = 10.0
@export var max_distance: float = 50.0
@export var mortar_rotation_speed: float = 3.0
@onready var mortar = $Mortar
var is_rotating: bool = false



func approximate_player_pos() -> Vector2:
	var player_pos = get_parent().get_player_position()
	var distance_to_bunker = player_pos.distance_to(get_global_position())
	var radius = clamp(distance_to_bunker, min_distance, max_distance)

	var random_angle = randf() * 0.5 * PI
	var random_radius = randf() * radius
	var approximate_position = get_parent().get_player_position() + Vector2(cos(random_angle), sin(random_angle)) * random_radius

	return approximate_position


func rotate_towards_approx_position(approx_position, delta):
	var angle_to_player = get_global_position().direction_to(approx_position).angle() - PI / 2

	mortar.rotation = rotate_toward(mortar.rotation, angle_to_player, mortar_rotation_speed * delta)
	
	
func _process(delta):
	ai_behaviour(delta)


func ai_behaviour(delta):
	var player_pos = approximate_player_pos()
	rotate_towards_approx_position(player_pos, delta)


func release_shot():
	shot_released.emit()

