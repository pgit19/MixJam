extends Camera2D

@onready var player_instance = get_parent().get_node("Player")

const camera_speed = 0.1
var is_player_turn : bool


func _ready():
	TurnManager.player_turn_started.connect(_on_player_turn_started)
	TurnManager.enemy_turn_started.connect(_on_enemy_turn_started)


func _process(delta):
	if is_player_turn:
		look_at_player()
	else:
		look_at_map()

func look_at_player():
	position = position.lerp(player_instance.position + Vector2(300, 0), camera_speed)
	zoom = zoom.lerp(Vector2(0.8, 0.8), camera_speed)


func look_at_map():
	position = position.lerp(Vector2(1000, 0), camera_speed)
	zoom = zoom.lerp(Vector2(0.5, 0.5), camera_speed)


func _on_player_turn_started():
	is_player_turn = true


func _on_enemy_turn_started():
	is_player_turn = false
