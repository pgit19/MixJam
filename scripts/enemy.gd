extends Character

@export var min_distance: float = 10.0
@export var max_distance: float = 50.0
@export var mortar_rotation_speed: float = 3.0
@onready var mortar = $Mortar
@onready var player_ray_cast = $PlayerRayCast
@onready var health_bar = $HealthBarContainer/HealthBar
var is_rotating: bool = false
var hp = 100

const bullet_scene = preload("res://scenes/bullet.tscn")


func _ready():
	CombatUtils.character_damaged.connect(_on_character_damaged)
	set_up_health_bar()


func set_up_health_bar():
	health_bar.set_max(hp)
	health_bar.set_value(hp)


func _on_character_damaged(damage : float, p_character : Character):
	if p_character == self:
		hp = max(0, hp - damage)
		health_bar.set_value(hp)
		if hp == 0:
			queue_free()


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
	var shot_position = get_parent().get_player_position() if can_see_player else get_random_position_around_player()
	instantiate_bullet(shot_position)


func get_random_position_around_player():
	var distance = randf_range(200, 600)
	var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	return get_parent().get_player_position() + (direction * distance)


func instantiate_bullet(p_target_position):
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.set_up(position, p_target_position)
	get_parent().add_child(bullet_instance)
	pass
