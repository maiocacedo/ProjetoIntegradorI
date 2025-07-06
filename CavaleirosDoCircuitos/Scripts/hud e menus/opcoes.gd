extends Control

# 
@onready var music_slider     = $HBoxContainer/VBoxContainer/music_slider
@onready var sounds_slider    = $HBoxContainer/VBoxContainer/volume_slider
@onready var mute_music_btn   = $HBoxContainer/VBoxContainer/mute_music
@onready var mute_sounds_btn  = $HBoxContainer/VBoxContainer/mute_sounds

var musicBusIndex  = AudioServer.get_bus_index("music")
var soundsBusIndex = AudioServer.get_bus_index("sounds")

func _ready() -> void:
	# Define um nível seguro inicial

	# Inicializa sliders (assumindo min=0 e max=100 no Inspector)
	music_slider.value  = db_to_slider(AudioServer.get_bus_volume_db(musicBusIndex))
	sounds_slider.value = db_to_slider(AudioServer.get_bus_volume_db(soundsBusIndex))

	# Usa propriedade correta e método correto
	mute_music_btn.button_pressed  = AudioServer.is_bus_mute(musicBusIndex)
	mute_sounds_btn.button_pressed = AudioServer.is_bus_mute(soundsBusIndex)


func _on_music_value_changed(value: float) -> void:
	var db = slider_to_db(value)
	AudioServer.set_bus_volume_db(musicBusIndex, db)


func _on_volume_value_changed(value: float) -> void:
	var db = slider_to_db(value)
	AudioServer.set_bus_volume_db(soundsBusIndex, db)


func _on_mute_music_toggled(pressed: bool) -> void:
	AudioServer.set_bus_mute(musicBusIndex, pressed)


func _on_mute_sounds_toggled(pressed: bool) -> void:
	AudioServer.set_bus_mute(soundsBusIndex, pressed)


# Converte slider (0..100) → dB (–80..0)
func slider_to_db(value: float) -> float:
	return lerp(-50.0, 5.0, clamp(value / 100.0, 0.0, 1.0))


# Converte dB (–80..0) → slider (0..100)
func db_to_slider(db: float) -> float:
	return clamp((db + 50.0) / 55.0 * 100.0, 0.0, 100.0)


func _on_voltar_pressed() -> void:
	if get_tree().current_scene.name == "opcoes":
		get_tree().change_scene_to_file("res://Cenas/hud e menus/menu.tscn")
	else:
		visible = false
