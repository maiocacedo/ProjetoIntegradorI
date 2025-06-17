extends CharacterBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): #verifica o grupo do player
		if PlayerData.hasDamageUpgrade and not PlayerData.damageUpgradeApplied: #se tiver o upgrade e não tiver sido usado
			print("usou a capa")
			queue_free() #apaga o inimigo da cena
			PlayerData.damageUpgradeApplied = true #impede que seja usado de novo
		else:
			get_tree().reload_current_scene() #recarrega a cena / morre
			PlayerData.ResetVariables()
