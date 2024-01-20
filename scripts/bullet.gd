class_name Bullet extends Node2D

var start_position : Vector2
var target_position : Vector2


func set_up(p_position: Vector2, p_target_position : Vector2):
	position = p_position
	start_position = p_position
	target_position = p_target_position


func _physics_process(delta):
	var duration = (target_position - position).length() / 400
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.finished.connect(queue_free)
	tween.tween_property(self, "position", target_position, duration)

