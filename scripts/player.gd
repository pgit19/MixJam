extends CharacterBody2D

var direction := Vector2.RIGHT


func _ready():
	PlayerStats.health = PlayerStats.max_health


func _physics_process(_delta):
	handle_movement_input()
	move_and_slide()
	print(position)


func handle_movement_input():
	direction = Vector2(Input.get_axis("a", "d"), Input.get_axis("w", "s")).normalized()
	velocity = PlayerStats.move_speed * direction
