extends Area2D
@onready var spikes: Sprite2D = $spikes
@onready var colision: CollisionShape2D = $colision
@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	pass


func _on_body_entered(_body: Node2D) -> void: # caso o player encoste nos espinhos ele reset a fase
	if _body.is_in_group("player"): # grupo do player
		_body.die()
	
		morte.playing = true 
		timer.start()



func _on_timer_timeout() -> void:
	GameManager.call_deferred("abrir_tela_de_morte","Morte Morrida")
