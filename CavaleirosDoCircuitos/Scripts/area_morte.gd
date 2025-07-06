extends Area2D

@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal morrendo()

func _on_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("player"):
		_body.die()
	emit_signal("morrendo")
	morte.playing = true 
	timer.start()
	

func _on_timer_timeout() -> void:
	GameManager.call_deferred("abrir_tela_de_morte","Morte Morrida")
