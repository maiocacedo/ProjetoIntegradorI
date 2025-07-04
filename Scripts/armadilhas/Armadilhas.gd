extends StaticBody2D

func Verificacao(body: Node2D, morte: AudioStreamPlayer2D, timer: Timer):
	if body.is_in_group("player"): #verifica o grupo
		if PlayerData.hasPergaminho and not PlayerData.pergaminhoUsado:
			body.Knockback(global_position) #chama a função
			print("Usou o pergaminho") 
			PlayerData.pergaminhoUsado = true #impede que seja usado de novo
		else:
			body.die()
			morte.playing = true 
			timer.start()
			PlayerData.pergaminhoUsado = false
			
func ReloadScene():
	get_tree().reload_current_scene() #recarrega a cena
	PlayerData.ResetVariables()
