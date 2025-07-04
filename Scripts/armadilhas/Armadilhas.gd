extends Area2D

func Verificacao(body: Node2D):
	if body.is_in_group("Player"): #verifica o grupo
		if PlayerData.hasPergaminho and not PlayerData.pergaminhoUsado:
			body.Knockback(global_position) #chama a função
			print("Usou o pergaminho") 
			PlayerData.pergaminhoUsado = true #impede que seja usado de novo
		else:
			call_deferred("ReloadScene") #espera acabar o retorno de fisica
			
func ReloadScene():
	get_tree().reload_current_scene() #recarrega a cena
	PlayerData.ResetVariables()
