extends Camera2D

@onready var player_instance = get_parent().get_node("Player")

const camera_speed = 0.2

func _process(delta):
	position = position.lerp(player_instance.position, camera_speed)
