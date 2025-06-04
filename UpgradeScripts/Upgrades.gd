class_name SpeedUpgrade

extends Resource

var speedBuff: float = 50.0 #se quiser mudar a quantidade de buff, é só mudar o valor
	
func Aplicar(stats, player):
	if player.hasSpeedUpgrade and not player.speedUpgradeApplied: #se tiver o upgrade
		stats["speed"] += speedBuff #aplica o buff
		player.speedUpgradeApplied = true #impede que seja aplicado várias vezes
