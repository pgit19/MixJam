class_name Bullet extends Node2D

var start_position : Vector2
var target_position : Vector2
var bullet_speed_scale: float
var bullet_duration: float = 700

@onready var bullet_animation = $BULLETANIMATION
@onready var bullet_timer = $bullet_timer

func _ready():	
	bullet_animation.play()
	bullet_animation.speed_scale = bullet_speed_scale
	bullet_timer.wait_time = (target_position - start_position).length() / bullet_duration
	bullet_timer.start()
	

func set_up(p_position: Vector2, p_target_position : Vector2):
	position = p_position
	start_position = p_position
	target_position = p_target_position
	
	bullet_speed_scale = 1 / ((target_position - start_position).length() / bullet_duration)
	rotation = (target_position - start_position).normalized().angle() + PI / 2



func _physics_process(_delta):
	var t = 1.0 - (bullet_timer.time_left / bullet_timer.wait_time)
	var scale_factor = 0.15 + cos(PI / 2 - PI * t) * 0.15
	
	position = lerp(start_position, target_position, t)
	
	bullet_animation.scale = Vector2(scale_factor, scale_factor)
	
	#var tween = create_tween().set_parallel()
	#tween.finished.connect(_on_tween_finished)
	#tween.tween_property(self, "position", target_position, duration)
	#tween.tween_property(bullet_animation, "frame", 5, duration)


func spawn_explosion():
	var explosion_instance = Preloads.explosion_scene.instantiate()
	explosion_instance.position = position
	get_parent().add_child(explosion_instance)

func _on_bullet_timer_timeout():
	spawn_explosion()
	queue_free()
