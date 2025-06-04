class_name Upgrade

extends Resource

var speedBuff: float = 50.0 #se quiser mudar a quantidade de buff, é só mudar o valor
	
func aplicar(stats):
	stats["speed"] += speedBuff
