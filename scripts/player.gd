extends Character

enum State {MOVING, SHOOTING}

@onready var game_instance = get_parent()

var direction := Vector2.RIGHT
var current_state := State.MOVING


func _ready():
	PlayerStats.health = PlayerStats.max_health


func _physics_process(_delta):
	if current_state == State.MOVING:
		handle_movement_input()
	handle_shot_input()
	move_and_slide()


func handle_movement_input():
	direction = Vector2(Input.get_axis("a", "d"), Input.get_axis("w", "s")).normalized()
	velocity = PlayerStats.move_speed * direction


func handle_shot_input():
	if Input.is_action_just_pressed("space"):
		shoot()
	elif Input.is_action_just_released("space"):
		release_shot()


func shoot():
	current_state = State.SHOOTING
	velocity = Vector2.ZERO
	var shot_instance : Shot = Preloads.shot_scene.instantiate()
	shot_instance.set_up(self, Utils.get_mouse_direction_relative_to_position(position))
	game_instance.add_child(shot_instance)


func release_shot():
	current_state = State.MOVING
	shot_released.emit()
