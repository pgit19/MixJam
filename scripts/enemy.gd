extends Node2D

@export var min_distance: float = 10.0
@export var max_distance: float = 50.0
@export var mortar_rotation_speed: float = 3.0
@onready var mortar = $Mortar
var is_rotating: bool = false

func _ready():
	pass 


func approximate_player_pos() -> Vector2:
	var player_pos = PlayerStats.player_pos
	var distance_to_bunker = player_pos.distance_to(get_global_position())
	var radius = clamp(distance_to_bunker, min_distance, max_distance)

	var random_angle = randf() * 2.0 * PI
	var random_radius = randf() * radius
	var approximate_position = PlayerStats.player_pos + Vector2(cos(random_angle), sin(random_angle)) * random_radius

	return approximate_position


func rotate_towards_approx_position(approx_position, delta):
	var direction = approx_position - PlayerStats.player_pos
	var angle_to_player = get_global_position().direction_to(PlayerStats.player_pos).angle()

	mortar.rotation = move_toward(mortar.rotation, angle_to_player, mortar_rotation_speed * delta)
	
	
func _process(delta):
	var player_approx_pos = approximate_player_pos()
	rotate_towards_approx_position(player_approx_pos, delta)
	
