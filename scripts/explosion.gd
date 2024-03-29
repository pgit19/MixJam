extends Area2D

@export var explosion_sound : AudioStream
@onready var animation = $Animation

func _ready():
	z_index = ZIndex.explosion
	body_entered.connect(calculate_damage)
	AudioManager.play_sound_at_position(explosion_sound, position)
	animation.play()
	await get_tree().create_timer(1.5).timeout
	queue_free()


func calculate_damage(p_character : Character):
	var distance = max(0, (p_character.position - position).length() - 80)
	var damage
	if distance == 0:
		damage = 60
	else:
		var ratio = distance / 300
		damage = lerp(60, 1, ratio)
	CombatUtils.damage_character(damage, p_character)
