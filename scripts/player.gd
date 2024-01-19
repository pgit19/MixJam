extends CharacterBody2D

@onready var game_instance = get_parent()

var direction := Vector2.RIGHT


func _ready():
	PlayerStats.health = PlayerStats.max_health


func _physics_process(_delta):
	handle_movement_input()
	handle_shot_input()
	move_and_slide()


func handle_movement_input():
	direction = Vector2(Input.get_axis("a", "d"), Input.get_axis("w", "s")).normalized()
	velocity = PlayerStats.move_speed * direction


func handle_shot_input():
	if Input.is_action_just_pressed("space"):
		shoot()


func shoot():
	var shot_instance : Shot = Preloads.shot_scene.instantiate()
	#TODO: Mouse Position
	#shot_instance.set_up(position,)
	shot_instance.set_up(position, Vector2.RIGHT)
	game_instance.add_child(shot_instance)
