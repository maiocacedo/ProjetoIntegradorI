extends Area2D

@export var label_path : NodePath
@onready var label: Label = null

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	if label_path != null and has_node(label_path):
		label = get_node(label_path)
		label.visible = false


func _on_body_entered(body: Node2D) -> void:

	if label:
		label.visible = true
	audio_stream_player_2d.playing = true

func _on_body_exited(body: Node2D) -> void:
	if label:
		label.visible = false
