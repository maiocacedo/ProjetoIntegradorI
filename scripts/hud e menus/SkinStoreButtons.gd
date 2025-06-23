extends Node

#referencias aos botões na cena
@onready var skin1Button = $Skin1Button
@onready var skin2Button = $Skin2Button
@onready var skin3Button = $Skin3Button

var skin1Purchased: bool = false
var skin2Purchased: bool = false
var skin3Purchased: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for Buttons in get_children():
		if Buttons is Button:
			Buttons.pressed.connect(ButtonPressed.bind(Buttons))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not skin1Purchased:
		skin1Button.text = str(PlayerData.skins[1]["price"]) + " Estrelas"
	elif skin1Purchased:
		if PlayerData.skins[1]["inUse"]:
			skin1Button.text = "Selecionada"
		else:
			skin1Button.text = "Não Selecionada"
	
	if not skin2Purchased:
		skin2Button.text = str(PlayerData.skins[2]["price"]) + " Estrelas"
	elif skin2Purchased:
		if PlayerData.skins[2]["inUse"]:
			skin2Button.text = "Selecionada"
		else:
			skin2Button.text = "Não selecionada"
			
	if not skin3Purchased:
		skin3Button.text = str(PlayerData.skins[3]["price"]) + " Estrelas"
	elif skin3Purchased:
		if PlayerData.skins[3]["inUse"]:
			skin3Button.text = "Selecionada"
		else:
			skin3Button.text = "Não selecionada"

func ButtonPressed(button):
	match button.name:
		"Skin1Button":
			if not skin1Purchased:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[1]["price"]:
					skin1Purchased = true
					PlayerData.skins[1]["inUse"] = true
					
					for skin in PlayerData.skins:
						if skin["name"] != "Skin1":
							skin["inUse"] = false
			
			elif skin1Purchased:
				PlayerData.skins[1]["inUse"] = !PlayerData.skins[1]["inUse"]
				
				if PlayerData.skins[1]["inUse"]:
					for skin in PlayerData.skins:
						if skin["name"] != "Skin1":
							skin["inUse"] = false
				else:
					PlayerData.skins[0]["inUse"] = true
		
		"Skin2Button":
			if not skin2Purchased:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[2]["price"]:
					skin2Purchased = true
					PlayerData.skins[2]["inUse"] = true
					
					for skin in PlayerData.skins:
						if skin["name"] != "Skin2":
							skin["inUse"] = false
							
			elif skin2Purchased:
				PlayerData.skins[2]["inUse"] = !PlayerData.skins[2]["inUse"]
				
				if PlayerData.skins[2]["inUse"]:
					for skin in PlayerData.skins:
						if skin["name"] != "Skin2":
							skin["inUse"] = false
				else:
					PlayerData.skins[0]["inUse"] = true
		
		"Skin3Button":
			if not skin3Purchased:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[3]["price"]:
					skin3Purchased = true
					PlayerData.skins[3]["inUse"] = true
					
					for skin in PlayerData.skins:
						if skin["name"] != "Skin3":
							skin["inUse"] = false
			elif skin1Purchased:
				PlayerData.skins[3]["inUse"] = !PlayerData.skins[3]["inUse"]
				
				if PlayerData.skins[3]["inUse"]:
					for skin in PlayerData.skins:
						if skin["name"] != "Skin3":
							skin["inUse"] = false
				else:
					PlayerData.skins[0]["inUse"] = true
		
		"UpgradesButton":
			get_tree().change_scene_to_file("res://Cenas/hud e menus/Store.tscn")
			
		"VoltarButton":
			get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")
