class_name Bullet extends Node2D

var start_position : Vector2
var target_position : Vector2


func set_up(p_position: Vector2, p_target_position : Vector2):
	position = p_position
	start_position = p_position
	target_position = p_target_position


func _physics_process(_delta):
	var duration = (target_position - position).length() / 400
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.finished.connect(_on_tween_finished)
	tween.tween_property(self, "position", target_position, duration)


func spawn_explosion():
	var explosion_instance = Preloads.explosion_scene.instantiate()
	explosion_instance.position = position
	get_parent().add_child(explosion_instance)


func _on_tween_finished():
	spawn_explosion()
	queue_free()
	
	
