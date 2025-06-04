extends Area2D

@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		player = body
		timer.start()



func _on_timer_timeout() -> void:
	if player.hasPergaminho and not player.pergaminhoUsado:
		print("Usou o pergaminho") #place holder para mostrar que está funcionando
		#aqui ficaria a lógica de não morte
		player.pergaminhoUsado = true
		return
		
	get_tree().reload_current_scene()
