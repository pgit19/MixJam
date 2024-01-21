extends Camera2D

@onready var player_instance = get_parent().get_node("Player")

const camera_speed = 0.2


func _ready():
	TurnManager.player_turn_started.connect(_on_player_turn_started)
	TurnManager.enemy_turn_started.connect(_on_enemy_turn_started)


func _process(delta):
	position = position.lerp(player_instance.position, camera_speed)


func determine_position():
	#TODO: Make camera follow mouse a bit
	var player_position = player_instance.position
	var mouse_position = get_global_mouse_position()
	return (player_position + mouse_position) / 2
	
	
func _on_player_turn_started():
	pass


func _on_enemy_turn_started():
	pass
