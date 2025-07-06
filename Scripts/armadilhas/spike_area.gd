extends Area2D

@onready var spikes: Sprite2D = $spikes
@onready var colision: CollisionShape2D = $colision
@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D

var ja_morreu: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.alive: #verifica o grupo
		if PlayerData.hasPergaminho and not PlayerData.pergaminhoUsado:
			body.Knockback(global_position) #chama a função
			print("Usou o pergaminho") 
			PlayerData.pergaminhoUsado = true #impede que seja usado de novo
			var inventory = get_tree().get_first_node_in_group("inventory")
			inventory.removerItem(ItemDB.getItem(4), null)

		else:
			body.die()
			morte.playing = true 
			timer.start()
			PlayerData.pergaminhoUsado = false

func _on_timer_timeout() -> void:
	GameManager.call_deferred("abrir_tela_de_morte", "Tropeçou nos espinhos!")
