extends Area2D

@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal morrendo()

func _on_body_entered(_body: Node2D) -> void:
	timer.start()
	morte.playing = true 



func _on_timer_timeout() -> void:
	emit_signal("morrendo")
