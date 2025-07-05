class_name LifeUpgrade
extends Resource

var atributes = {
	"price" : 18
}

func Aplicar():
	if not PlayerData.pergaminhoUsado:
		PlayerData.hasPergaminho = true
		print("Pergaminho ativado")
