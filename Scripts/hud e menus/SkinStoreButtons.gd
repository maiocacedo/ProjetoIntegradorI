extends Node

#referencias aos botões na cena
@onready var skin1Button = $Skin1Button
@onready var skin2Button = $Skin2Button
@onready var skin3Button = $Skin3Button

var skin1Purchased: bool = PlayerData.skins[1]["purchased"]
var skin2Purchased: bool = PlayerData.skins[2]["purchased"]


var pressedText = "res://Assets/Inventory/slot_inv.png"
var releasedpressedText = "res://Assets/Inventory/slot_inv_pressed.png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for Buttons in get_children():
		if Buttons is Button:
			Buttons.pressed.connect(ButtonPressed.bind(Buttons))
			
	print(PlayerData.skins[0]["inUse"])
	print(PlayerData.skins[1]["inUse"])
	print(PlayerData.skins[2]["inUse"])
	if PlayerData.skins[0]["inUse"]:
		$Skin1Button/TextureRect.texture = load(releasedpressedText)
	if PlayerData.skins[1]["inUse"]:
		$Skin2Button/TextureRect.texture = load(releasedpressedText)
	if PlayerData.skins[2]["inUse"]:
		$Skin3Button/TextureRect.texture = load(releasedpressedText)
		
	if not skin1Purchased:
		$Skin2Button/TextureRect/skin2.modulate = Color(0.8, 0.8, 0.8, 0.6)
	if not skin2Purchased:
		$Skin3Button/TextureRect/skin3.modulate = Color(0.8, 0.8, 0.8, 0.6)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ButtonPressed(button):
	
	var text = load(releasedpressedText)
	var textVazia = load(pressedText)
	
	match button.name:
		"Skin1Button":
			if !PlayerData.skins[0]["inUse"]:
				PlayerData.skins[0]["inUse"] = !PlayerData.skins[0]["inUse"]
			if PlayerData.skins[0]["inUse"]:
				$Skin1Button/TextureRect.texture = text
				$Skin2Button/TextureRect.texture = textVazia
				$Skin3Button/TextureRect.texture = textVazia
			if PlayerData.skins[0]["inUse"]:
				for skin in PlayerData.skins:
					if skin["name"] != "default":
						skin["inUse"] = false
		"Skin2Button":
			if not skin1Purchased:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[1]["price"]:
					skin1Purchased = true
					$Skin2Button/TextureRect/skin2.modulate = Color(1, 1, 1, 1)
					PlayerData.skins[1]["inUse"] = true
					PlayerData.skins[1]["purchased"] = true
					$Skin1Button/TextureRect.texture = textVazia
					$Skin2Button/TextureRect.texture = text
					$Skin3Button/TextureRect.texture = textVazia
					for skin in PlayerData.skins:
						if skin["name"] != "skin1":
							skin["inUse"] = false
							
			elif skin1Purchased:
				$Skin2Button/TextureRect/skin2.modulate = Color(1, 1, 1, 1)
				if !PlayerData.skins[1]["inUse"]:
					PlayerData.skins[1]["inUse"] = !PlayerData.skins[1]["inUse"]
				if PlayerData.skins[1]["inUse"]:
					$Skin1Button/TextureRect.texture = textVazia
					$Skin2Button/TextureRect.texture = text
					$Skin3Button/TextureRect.texture = textVazia
				if PlayerData.skins[1]["inUse"]:
					for skin in PlayerData.skins:
						if skin["name"] != "skin1":
							skin["inUse"] = false

		
		"Skin3Button":
			if not skin2Purchased:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[2]["price"]:
					$Skin3Button/TextureRect/skin3.modulate = Color(1, 1, 1, 1)
					skin2Purchased = true
					PlayerData.skins[2]["inUse"] = true
					PlayerData.skins[2]["purchased"] = true
					$Skin1Button/TextureRect.texture = textVazia
					$Skin2Button/TextureRect.texture = textVazia
					$Skin3Button/TextureRect.texture = text
					for skin in PlayerData.skins:
						if skin["name"] != "skin1":
							skin["inUse"] = false
			elif skin2Purchased:
				$Skin3Button/TextureRect/skin3.modulate = Color(1, 1, 1, 1)
				if !PlayerData.skins[2]["inUse"]:
					PlayerData.skins[2]["inUse"] = !PlayerData.skins[2]["inUse"]
				if PlayerData.skins[2]["inUse"]:
					$Skin1Button/TextureRect.texture = textVazia
					$Skin2Button/TextureRect.texture = textVazia
					$Skin3Button/TextureRect.texture = text
				if PlayerData.skins[2]["inUse"]:
					for skin in PlayerData.skins:
						if skin["name"] != "skin2":
							skin["inUse"] = false
		"UpgradesButton":
			SaveManager.update_skins_progress("default", PlayerData.skins[0]["inUse"], true)
			SaveManager.update_skins_progress("skin1",PlayerData.skins[1]["inUse"], skin1Purchased)
			SaveManager.update_skins_progress("skin2", PlayerData.skins[2]["inUse"], skin2Purchased)
			
			
			get_tree().change_scene_to_file("res://Cenas/hud e menus/Store.tscn")
			
		"VoltarButton":
			print(PlayerData.skins[0]["inUse"])
			print(PlayerData.skins[1]["inUse"])
			print(PlayerData.skins[2]["inUse"])
			SaveManager.update_skins_progress("default", PlayerData.skins[0]["inUse"], true)
			SaveManager.update_skins_progress("skin1",PlayerData.skins[1]["inUse"], skin1Purchased)
			SaveManager.update_skins_progress("skin2", PlayerData.skins[2]["inUse"], skin2Purchased)
			
	
			get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")
			
	if skin2Purchased:
		$Skin2Button/TextureRect/skin2.modulate = Color(1, 1, 1, 1)
	if skin2Purchased:
		$Skin3Button/TextureRect/skin3.modulate = Color(1, 1, 1, 1)
