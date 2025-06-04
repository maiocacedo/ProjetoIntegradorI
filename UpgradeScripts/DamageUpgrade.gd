class_name DamageUpgrade

extends Resource

var damageBonus: int = 0

func Aplicar(stats, player):
	if player.hasDialogo or player.hasEspada: #caso tenha algum dos 2 buffs, ele aumenta o dano
		stats["dano"] += damageBonus #aumenta o dano
		player.damageUpgradeApplied = true #impede que seja aplicado denovo
