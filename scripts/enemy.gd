extends Character

@export var min_distance: float = 10.0
@export var max_distance: float = 50.0
@export var mortar_rotation_speed: float = 3.0
@onready var mortar = $Mortar
@onready var player_ray_cast = $PlayerRayCast
var is_rotating: bool = false

const bullet_scene = preload("res://scenes/bullet.tscn")



func rotate_towards_approx_position(approx_position, delta):
	var angle_to_player = get_global_position().direction_to(approx_position).angle() - PI / 2

	mortar.rotation = rotate_toward(mortar.rotation, angle_to_player, mortar_rotation_speed * delta)
	
	
func _process(delta):
	point_ray_cast_towards_player()
	rotate_towards_approx_position(get_parent().get_player_position(), delta)


func point_ray_cast_towards_player():
	player_ray_cast.set_target_position(get_parent().get_player_position() - position)


func shoot():
	var can_see_player : bool = false if player_ray_cast.is_colliding() else true
	var shot_position = get_parent().get_player_position()
	instantiate_bullet(shot_position)


func instantiate_bullet(p_target_position):
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.set_up(position, p_target_position)
	get_parent().add_child(bullet_instance)
	pass
