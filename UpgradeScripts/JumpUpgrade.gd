class_name JumpUpgrade

extends Resource

var jumpBonus: float = 70.0 #caso queira aumentar ou diminuir, mude o valor

func Aplicar(stats, player):
	if player.hasJumpUpgrade and not player.jumpUpgradeApplied: #caso tenha o upgrade
		stats["jumpSpeed"] -= jumpBonus #como a velocidade do jump é negativa, então é -
		player.jumpUpgradeApplied = true #impede que aplique o buff novamente
