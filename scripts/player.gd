class_name Player extends Character


enum State {MOVING, SHOOTING, INACTIVE}

@onready var turret = $Turret
@onready var tank = $Tank
@onready var audio_player = $AudioStreamPlayer2D
@onready var windup_key = $Tank/WINDUP_KEY
@onready var tank_base = $Tank/TANKBASE

var direction := Vector2.RIGHT
var current_state := State.MOVING


func _ready():
	TurnManager.player_turn_started.connect(_on_turn_started)
	#TODO: Make able to update sound position
	PlayerStats.health = PlayerStats.max_health
	PlayerStats.fuel = PlayerStats.max_fuel
	TurnManager.start_game()


func _physics_process(delta):
	if not current_state == State.INACTIVE:
		if current_state == State.MOVING and PlayerStats.fuel > 0:
			use_fuel(delta)
			drive_logic(delta)
		else:
			velocity = Vector2.ZERO
		if not current_state == State.SHOOTING:
			handle_turret_rotation(delta)
		handle_shot_input()
		move_and_slide()

func _process(_delta):
	determine_windup_key_speed()
	handle_tracks_stop()


func handle_turret_rotation(delta):
	var dir_to_mouse = Utils.get_mouse_direction_relative_to_position(turret.global_position).angle()
	turret.global_rotation = rotate_toward(turret.global_rotation, dir_to_mouse, 3 * delta)
	

func handle_shot_input():
	if Input.is_action_just_pressed("left_click"):
		shoot()
	elif Input.is_action_just_released("left_click") and current_state == State.SHOOTING:
		release_shot()


func drive_logic(delta):
	var motion = Vector2()

	if Input.is_action_pressed("w"):
		motion.y -= 1
		tank_base.play()
		
	if Input.is_action_pressed("s"):
		motion.y += 1
		tank_base.play_backwards()

	if Input.is_action_pressed("a"):
		tank.rotation -= PlayerStats.rotation_speed * delta
	if Input.is_action_pressed("d"):
		tank.rotation += PlayerStats.rotation_speed * delta

	velocity = motion.rotated(tank.rotation) * PlayerStats.move_speed


func shoot():
	current_state = State.SHOOTING
	var shot_instance : Shot = Preloads.shot_scene.instantiate()
	shot_instance.set_up(self, turret.global_transform.x)
	get_parent().add_child(shot_instance)
	windup_key.stop()


func release_shot():
	current_state = State.MOVING
	shot_released.emit()
	print("Player Turn ended")
	AudioManager.play_sound_at_position(shot_sound, position)
	current_state = State.INACTIVE
	audio_player.stop()
	await get_tree().create_timer(2).timeout
	TurnManager.end_turn()



func use_fuel(delta : float):
	var fuel_usage_per_second = 10 if velocity == Vector2.ZERO else 30
	PlayerStats.fuel -= fuel_usage_per_second * delta
	if PlayerStats.fuel <= 0:
		audio_player.stop()


func determine_windup_key_speed():
	windup_key.set_speed_scale((PlayerStats.fuel / 100))


func handle_tracks_stop():
	if velocity == Vector2.ZERO:
		tank_base.stop()


func _on_turn_started():
	print("Player Turn Started")
	PlayerStats.fuel = PlayerStats.max_fuel
	current_state = State.MOVING
	audio_player.play()
	windup_key.play()
