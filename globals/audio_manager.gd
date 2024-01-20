extends Node2D


func _ready():
	set_process_mode(Node.PROCESS_MODE_ALWAYS)


func reset():
	for i in get_children():
		i.queue_free()


func play_sound_at_position(p_stream : AudioStream, p_position : Vector2):
	var audio_stream_player_2d = AudioStreamPlayer2D.new()
	audio_stream_player_2d.set_stream(p_stream)
	audio_stream_player_2d.set_global_position(p_position)
	audio_stream_player_2d.finished.connect(_on_finished_playing_audio.bind(audio_stream_player_2d))
	add_child(audio_stream_player_2d)
	audio_stream_player_2d.play()


func play_global_sound(p_stream : AudioStream):
	var audio_stream_player = AudioStreamPlayer.new()
	print(audio_stream_player.get_bus())
	audio_stream_player.set_stream(p_stream)
	audio_stream_player.finished.connect(_on_finished_playing_audio.bind(audio_stream_player))
	add_child(audio_stream_player)
	audio_stream_player.play()


func _on_finished_playing_audio(audio_stream_player):
	audio_stream_player.queue_free()
