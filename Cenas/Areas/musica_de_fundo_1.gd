extends AudioStreamPlayer2D

@onready var musica: AudioStreamPlayer2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		# Recebendo a cena atual
		var cenaAtual = get_tree().current_scene
		if cenaAtual:
			_on_scene_changed(get_tree().current_scene)

func _on_scene_changed(new_scene: Node) -> void:
	match new_scene.name:
		"area_1":
			_play_music("res://Assets/music/tema_level_1.wav")
		_:
			_stop_music()
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	musica.playing = true

func _play_music(path: String) -> void:
	if musica.stream.resource_path != path:
		musica.stream = load(path)
		musica.play()

func _stop_music() -> void:
	musica.stop()
