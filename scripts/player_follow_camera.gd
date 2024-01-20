extends Camera2D

@onready var player_instance = get_parent().get_node("Player")

const camera_speed = 0.2

func _process(delta):
	position = position.lerp(player_instance.position, camera_speed)


func determine_position():
	var player_position = player_instance.position
	var mouse_position = get_global_mouse_position()
	return (player_position + mouse_position) / 2
