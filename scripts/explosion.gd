extends Area2D

@export var explosion_sound : AudioStream

func _ready():
	body_entered.connect(calculate_damage)
	AudioManager.play_sound_at_position(explosion_sound, position)
	await get_tree().create_timer(0.3).timeout
	queue_free()


func calculate_damage(p_character : Character):
	var distance = max(0, (p_character.position - position).length() - 80)
	var damage
	if distance == 0:
		damage = 80
	else:
		var ratio = distance / 300
		damage = lerp(80, 1, ratio)
	CombatUtils.damage_character(damage, p_character)
