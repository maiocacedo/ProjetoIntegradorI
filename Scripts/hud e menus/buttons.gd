extends Node

#referencias aos botões da cena
@onready var shoesButton = $ShoesButton
@onready var capaButton = $CapeButton
@onready var refriButton = $RefriButton
@onready var pergaminhoButton = $PergaminhoButton

#referencias a outros scripts para puxar informações, NÃO DÁ PARA ALTERA-LAS
var speedUpgradeScript := preload("res://Scripts/upgrades/SpeedUpgrade.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://Scripts/upgrades/DamageUpgrade.gd").new() #referencia ao script de upgrade de dano
var jumpUpgradeScript := preload("res://Scripts/upgrades/JumpUpgrade.gd").new() #referencia ao script de upgrade de pulo
var pergaminhoScript := preload("res://Scripts/upgrades/LifeUpgrade.gd").new() #referencia ao sript do pergaminho

#variaveis que definem se foi comprado ou não
var shoesPurchased : bool = false
var capePurchased : bool = false
var refriPurchased : bool = false
var pergaminhoPurchased : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for Buttons in get_children():
		if Buttons is Button:
			Buttons.pressed.connect(_on_button_Pressed.bind(Buttons))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not shoesPurchased: #caso ele não tenha sido "comprado"
		shoesButton.text = str(speedUpgradeScript.atributes["price"]) + " Estrelas" #vai aparecer apenas o preço
	elif shoesPurchased: #caso tenha sido comprado, ele vai permitir desativar e ativar o buff
		if PlayerData.hasSpeedUpgrade:
			shoesButton.text = str("Ativado") #mostra que foi ativado o upgrade
		else:
			shoesButton.text = str("Desativado") #mostra que foi desativado
	
	if not capePurchased:
		capaButton.text = str(damageUpgradeScript.atributes["price"]) + " Estrelas"
	elif capePurchased:
		if PlayerData.hasDamageUpgrade:
			capaButton.text = str("Ativado")
		else:
			capaButton.text = str("Desativado")
	
	if not refriPurchased:
		refriButton.text = str(jumpUpgradeScript.atributes["price"]) + " Estrelas"
	elif refriPurchased:
		if PlayerData.hasJumpUpgrade:
			refriButton.text = str("Ativado")
		else:
			refriButton.text = str("Desativado")
			
	if not pergaminhoPurchased:
		pergaminhoButton.text = str(pergaminhoScript.atributes["price"]) + " Estrelas"
	elif pergaminhoPurchased:
		if PlayerData.hasPergaminho:
			pergaminhoButton.text = str("Ativado")
		else:
			pergaminhoButton.text = str("Desativado")
	
func _on_button_Pressed(button):
	match button.name: #é tipo um switch case
		"ShoesButton": #nome do botão
			if not shoesPurchased: #caso não tenha sido comprado
				if PlayerData.stats["estrelas"] >= speedUpgradeScript.atributes["price"]: #verifica se o player já tem a quantidade de dinheiro
					shoesPurchased = true #marca como comprado
					PlayerData.hasSpeedUpgrade = true #quando compra já marca como ativado, para impedir mal entendidos
			elif shoesPurchased: #caso já tenha sido comprado permite ativar e desativar
				PlayerData.hasSpeedUpgrade = !PlayerData.hasSpeedUpgrade #ativa e desativa
		
		"CapeButton":
			if not capePurchased:
				if PlayerData.stats["estrelas"] >= damageUpgradeScript.atributes["price"]:
					capePurchased = true
					PlayerData.hasDamageUpgrade = true
			elif capePurchased:
				PlayerData.hasDamageUpgrade = !PlayerData.hasDamageUpgrade

		"RefriButton":
			if not refriPurchased:
				if PlayerData.stats["estrelas"] >= jumpUpgradeScript.atributes["price"]:
					refriPurchased = true
					PlayerData.hasJumpUpgrade = true
			elif refriPurchased:
				PlayerData.hasJumpUpgrade = !PlayerData.hasJumpUpgrade
				
		"PergaminhoButton":
			if not pergaminhoPurchased:
				if PlayerData.stats["estrelas"] >= pergaminhoScript.atributes["price"]:
					pergaminhoPurchased = true
					PlayerData.hasPergaminho = true
			elif pergaminhoPurchased:
				PlayerData.hasPergaminho = !PlayerData.hasPergaminho
		
		"SkinsButton":
			get_tree().change_scene_to_file("res://Cenas/hud e menus/SkinsStore.tscn") #troca a cena
			#CHAT GPT RECOMENDOU CRIAR UM SCRIPT GLOBAL PARA TROCAR DE CENAS, MUDANDO DAI SÓ A STRING DA FUNÇÃO, QUE MUDARIA SÓ APÓS CENAS
			#CASO ESTEJA TUDO NA MESMA PASTA
