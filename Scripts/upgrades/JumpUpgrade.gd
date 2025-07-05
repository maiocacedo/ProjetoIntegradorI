class_name JumpUpgrade

extends Resource

var atributes = {
	"jumpBonus" : 70.0, #caso queira mudar o tamanho do buff, so mudar o valor
	"price" : 12
}

func Aplicar():
	if PlayerData.hasJumpUpgrade and not PlayerData.jumpUpgradeApplied: #caso tenha o upgrade
		PlayerData.stats["jumpSpeed"] -= atributes["jumpBonus"] #como a velocidade do jump é negativa, então é -
		PlayerData.jumpUpgradeApplied = true #impede que aplique o buff novamente
	
	elif not PlayerData.hasJumpUpgrade and PlayerData.jumpUpgradeApplied: #codigo para desativar o upgrade
		PlayerData.stats["jumpSpeed"] += atributes["jumpBonus"] #reverte o buff
		PlayerData.jumpUpgradeApplied = false #permite reaplicar novamente
