extends Area2D

@onready var spikes: Sprite2D = $spikes
@onready var colision: CollisionShape2D = $colision
@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D

var ja_morreu: bool = false

func _on_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("player") and _body.alive:
		_body.die()
		morte.playing = true
		timer.start()

func _on_timer_timeout() -> void:
	GameManager.call_deferred("abrir_tela_de_morte", "Tropeçou nos espinhos!")
