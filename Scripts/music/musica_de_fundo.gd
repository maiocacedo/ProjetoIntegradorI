extends Node

var musica: AudioStreamPlayer
var last_scene: Node = null

func _ready():
	musica = AudioStreamPlayer.new()
	add_child(musica)
	musica.bus = "music" # define canal onde a música deve tocar
	last_scene = get_tree().current_scene
	if last_scene:
		_on_scene_changed(last_scene)

func _process(delta):
	var current_scene = get_tree().current_scene
	if current_scene != last_scene:
		last_scene = current_scene
		if current_scene:
			_on_scene_changed(current_scene)

func _on_scene_changed(new_scene: Node) -> void:
	print("Cena mudou para:", new_scene.name)
	match new_scene.name:
		"area_1", "area_2":
			_play_music("res://Assets/music/tema_level_1.wav")
		"menu_principal", "seletor_nivel", "opcoes", "creditos":
			_play_music("res://Assets/music/tema_menu.wav")
		_:
			_stop_music()

func _play_music(path: String) -> void:
	if !musica.stream or musica.stream.resource_path != path:
		musica.stream = load(path)
		musica.play()

func _stop_music() -> void:
	musica.stop()
