extends Node

#referencias aos botões da cena
@onready var shoesButton = $ShoesButton
@onready var capaButton = $CapeButton
@onready var refriButton = $RefriButton
@onready var pergaminhoButton = $PergaminhoButton

var pressedText = "res://Assets/Inventory/slot_inv.png"
var releasedpressedText = "res://Assets/Inventory/slot_inv_pressed.png"

#referencias a outros scripts para puxar informações, NÃO DÁ PARA ALTERA-LAS
var speedUpgradeScript := preload("res://Scripts/upgrades/SpeedUpgrade.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://Scripts/upgrades/DamageUpgrade.gd").new() #referencia ao script de upgrade de dano
var jumpUpgradeScript := preload("res://Scripts/upgrades/JumpUpgrade.gd").new() #referencia ao script de upgrade de pulo
var pergaminhoScript := preload("res://Scripts/upgrades/LifeUpgrade.gd").new() #referencia ao sript do pergaminho

#variaveis que definem se foi comprado ou não
var shoesPurchased : bool 
var capePurchased : bool
var refriPurchased : bool 
var pergaminhoPurchased : bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.load_progress()
	shoesPurchased = SaveManager.progress.get("itens", {}).get("shoes", {}).get("purchased", false)
	capePurchased = SaveManager.progress.get("itens", {}).get("cape", {}).get("purchased", false)
	refriPurchased = SaveManager.progress.get("itens", {}).get("refri", {}).get("purchased", false)
	pergaminhoPurchased = SaveManager.progress.get("itens", {}).get("pergaminho", {}).get("purchased", false)
	if not shoesPurchased:
		$ShoesButton/TenisMoldura.modulate = Color(0.8, 0.8, 0.8, 0.6)
	if not capePurchased:
		$CapeButton/EscudoEspinhosMoldura.modulate = Color(0.8, 0.8, 0.8, 0.6)
	if not refriPurchased:
		$RefriButton/RefrigeranteMoldura.modulate =  Color(0.8, 0.8, 0.8, 0.6)
	if not pergaminhoPurchased:
		$PergaminhoButton/EscudoMoldura.modulate =  Color(0.8, 0.8, 0.8, 0.6)
	
	for Buttons in get_children():
		if Buttons is Button:
			Buttons.pressed.connect(_on_button_Pressed.bind(Buttons))
	
	if(PlayerData.hasSpeedUpgrade):
		$ShoesButton/ShoesText.texture = load(releasedpressedText)
	if(PlayerData.hasDamageUpgrade):
		$CapeButton/CapeText.texture = load(releasedpressedText)
	if(PlayerData.hasJumpUpgrade):
		$RefriButton/RefriText.texture = load(releasedpressedText)
	if(PlayerData.hasPergaminho):
		$PergaminhoButton/PergaminhoText.texture = load(releasedpressedText)
	

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
	
	var text = load(releasedpressedText)
	var textVazia = load(pressedText)
	
	
	match button.name: #é tipo um switch case
		"ShoesButton": #nome do botão
			if shoesPurchased == false: #caso não tenha sido comprado
				if PlayerData.stats["estrelas"] >= speedUpgradeScript.atributes["price"]: #verifica se o player já tem a quantidade de dinheiro
					if not (PlayerData.hasDamageUpgrade and PlayerData.hasJumpUpgrade and PlayerData.hasPergaminho):
						PlayerData.hasSpeedUpgrade = true #quando compra já marca como ativado, para impedir mal entendidos
						$ShoesButton/ShoesText.texture = text
					else: 
						print("já tem 3 ai papai")
					shoesPurchased = true #marca como comprado
			elif shoesPurchased == true: #caso já tenha sido comprado permite ativar e desativar
				if PlayerData.hasSpeedUpgrade:
					$ShoesButton/ShoesText.texture = textVazia
					PlayerData.hasSpeedUpgrade = false
				elif not (PlayerData.hasDamageUpgrade and PlayerData.hasJumpUpgrade and PlayerData.hasPergaminho):
					$ShoesButton/ShoesText.texture = text
					PlayerData.hasSpeedUpgrade =  true#ativa e desativa
				else:
					print("já tem 3 ai papai")
				
		
		"CapeButton":
			if not capePurchased:
				if PlayerData.stats["estrelas"] >= damageUpgradeScript.atributes["price"]:
					
					if not (PlayerData.hasSpeedUpgrade and PlayerData.hasJumpUpgrade and PlayerData.hasPergaminho):
						PlayerData.hasDamageUpgrade = true
						$CapeButton/CapeText.texture = text
					else: 
						print("já tem 3 ai papai")
					capePurchased = true
			elif capePurchased:
				if PlayerData.hasDamageUpgrade:
					$CapeButton/CapeText.texture = textVazia
					PlayerData.hasDamageUpgrade = false
				elif not (PlayerData.hasSpeedUpgrade and PlayerData.hasJumpUpgrade and PlayerData.hasPergaminho):
					$CapeButton/CapeText.texture = text
					PlayerData.hasDamageUpgrade = true
				else:
					print("já tem 3 ai papai")
				
		"RefriButton":
			if not refriPurchased:
				if PlayerData.stats["estrelas"] >= jumpUpgradeScript.atributes["price"]:
					
					if not (PlayerData.hasSpeedUpgrade and PlayerData.hasDamageUpgrade and PlayerData.hasPergaminho):
						PlayerData.hasJumpUpgrade = true
						$RefriButton/RefriText.texture = text
					else: 
						print("já tem 3 ai papai")
					refriPurchased = true
			elif refriPurchased:
				if PlayerData.hasJumpUpgrade:
					$RefriButton/RefriText.texture = textVazia
					PlayerData.hasJumpUpgrade = false
				elif not (PlayerData.hasSpeedUpgrade and PlayerData.hasDamageUpgrade and PlayerData.hasPergaminho):
					$RefriButton/RefriText.texture = text
					PlayerData.hasJumpUpgrade = true
				else: 
					print("já tem 3 ai papai")
				
				
		"PergaminhoButton":
			if not pergaminhoPurchased:
				if PlayerData.stats["estrelas"] >= pergaminhoScript.atributes["price"]:
					if not (PlayerData.hasSpeedUpgrade and PlayerData.hasDamageUpgrade and PlayerData.hasJumpUpgrade):
						PlayerData.hasPergaminho = true
						$PergaminhoButton/PergaminhoText.texture = text
					else: 
						print("já tem 3 ai papai")
					pergaminhoPurchased = true
			elif pergaminhoPurchased:
				if PlayerData.hasPergaminho:
					$PergaminhoButton/PergaminhoText.texture = textVazia
					PlayerData.hasPergaminho = false
				elif not (PlayerData.hasSpeedUpgrade and PlayerData.hasDamageUpgrade and PlayerData.hasJumpUpgrade):
					$PergaminhoButton/PergaminhoText.texture = text
					PlayerData.hasPergaminho = true
				else:
					print("ja tem 3 ai papai")
		
		"SkinsButton":
			SaveManager.update_upgrade_progress("shoes", PlayerData.hasSpeedUpgrade, shoesPurchased)
			SaveManager.update_upgrade_progress("cape", PlayerData.hasDamageUpgrade, capePurchased)
			SaveManager.update_upgrade_progress("refri", PlayerData.hasJumpUpgrade, refriPurchased)
			SaveManager.update_upgrade_progress("pergaminho", PlayerData.hasPergaminho, pergaminhoPurchased)
			
			get_tree().change_scene_to_file("res://Cenas/hud e menus/SkinsStore.tscn") #troca a cena
			#CHAT GPT RECOMENDOU CRIAR UM SCRIPT GLOBAL PARA TROCAR DE CENAS, MUDANDO DAI SÓ A STRING DA FUNÇÃO, QUE MUDARIA SÓ APÓS CENAS
			#CASO ESTEJA TUDO NA MESMA PASTA
		"VoltarButton":
			SaveManager.update_upgrade_progress("shoes", PlayerData.hasSpeedUpgrade, shoesPurchased)
			SaveManager.update_upgrade_progress("cape", PlayerData.hasDamageUpgrade, capePurchased)
			SaveManager.update_upgrade_progress("refri", PlayerData.hasJumpUpgrade, refriPurchased)
			SaveManager.update_upgrade_progress("pergaminho", PlayerData.hasPergaminho, pergaminhoPurchased)
			
			get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")
			
	if shoesPurchased:
		$ShoesButton/TenisMoldura.modulate = Color(1, 1, 1, 1)
	if capePurchased:
		$CapeButton/EscudoEspinhosMoldura.modulate = Color(1, 1, 1, 1)
	if refriPurchased:
		$RefriButton/RefrigeranteMoldura.modulate =  Color(1, 1, 1, 1)
	if pergaminhoPurchased:
		$PergaminhoButton/EscudoMoldura.modulate =  Color(1, 1, 1, 1)
		
func _on_button_up(button):
	var text = load(releasedpressedText)
	print("A")
