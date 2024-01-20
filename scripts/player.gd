class_name Player extends Character

enum State {MOVING, SHOOTING, INACTIVE}

@onready var turret = $Turret
@onready var tank = $Tank

var direction := Vector2.RIGHT
var current_state := State.MOVING

func _ready():
	TurnManager.player_turn_started.connect(_on_turn_started)
	PlayerStats.health = PlayerStats.max_health


func _physics_process(delta):
	if not current_state == State.INACTIVE:
		if current_state == State.MOVING:
			handle_movement_input(delta)
		handle_shot_input()
		move_and_slide()


func handle_movement_input(delta):
	drive_logic(delta)
	handle_turret_rotation(delta)

func handle_turret_rotation(delta):
	var dir_to_mouse = Utils.get_mouse_direction_relative_to_position(turret.global_position).angle()
	turret.global_rotation = rotate_toward(turret.global_rotation, dir_to_mouse, 3 * delta)
	

func handle_shot_input():
	if Input.is_action_just_pressed("space"):
		shoot()
	elif Input.is_action_just_released("space"):
		release_shot()


func drive_logic(delta):
	var motion = Vector2()

	if Input.is_action_pressed("w"):
		motion.y -= 1
	if Input.is_action_pressed("s"):
		motion.y += 1

	if Input.is_action_pressed("a"):
		tank.rotation -= PlayerStats.rotation_speed * delta
	if Input.is_action_pressed("d"):
		tank.rotation += PlayerStats.rotation_speed * delta

	velocity = motion.rotated(tank.rotation) * PlayerStats.move_speed


func shoot():
	current_state = State.SHOOTING
	velocity = Vector2.ZERO
	var shot_instance : Shot = Preloads.shot_scene.instantiate()
	shot_instance.set_up(self, turret.global_transform.x)
	get_parent().add_child(shot_instance)


func release_shot():
	current_state = State.MOVING
	shot_released.emit()
	print("Player Turn ended")
	TurnManager.end_turn()
	current_state = State.INACTIVE


func _on_turn_started():
	print("Player Turn Started")
	current_state = State.MOVING
