extends Area2D


func _ready():
	body_entered.connect(calculate_damage)
	await get_tree().create_timer(0.3).timeout
	queue_free()


func calculate_damage(p_character : Character):
	var damage = 100
	var distance = (p_character.position - position).length()
	if distance < 10: 
		distance = 0
	damage = clamp(damage - distance, 0, 100)
	CombatUtils.damage_character(damage, p_character)
