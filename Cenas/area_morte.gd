extends Area2D

@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_body_entered(_body: Node2D) -> void:
	timer.start()
	morte.playing = true 



func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
