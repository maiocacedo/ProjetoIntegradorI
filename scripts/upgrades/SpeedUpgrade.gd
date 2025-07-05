class_name SpeedUpgrade

extends Resource

var atributes = {
	"speedBuff": 50.0,
	"price": 6
}

var speedBuff: float = 50.0 #se quiser mudar a quantidade de buff, é só mudar o valor
	
func Aplicar():
	if PlayerData.hasSpeedUpgrade and not PlayerData.speedUpgradeApplied: #se tiver o upgrade
		PlayerData.stats["speed"] += speedBuff #aplica o buff
		PlayerData.speedUpgradeApplied = true #impede que seja aplicado várias vezes
	
	elif not PlayerData.hasSpeedUpgrade and PlayerData.speedUpgradeApplied: #codigo para desativar o upgrade
		PlayerData.stats["speed"] -= atributes["speedBuff"] #reverte o buff
		PlayerData.speedUpgradeApplied = false #permite reaplicar novamente
