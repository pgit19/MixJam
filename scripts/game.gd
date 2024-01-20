extends SceneInterface

func _ready():
	PlayerStats.health_changed.connect(_on_player_health_changed)
	
	
func _on_player_health_changed(p_health : float):
	if p_health == 0:
		request_scene_change(Enums.SceneInterfaceType.DEATH_SCREEN)
