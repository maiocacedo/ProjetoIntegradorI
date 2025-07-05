extends Node

# Referências aos botões
@onready var skin1Button = $Skin1Button
@onready var skin2Button = $Skin2Button
@onready var skin3Button = $Skin3Button

var pressedText = "res://Assets/Inventory/slot_inv_pressed.png"
var releasedText = "res://Assets/Inventory/slot_inv.png"

func _ready() -> void:
	for button in get_children():
		if button is Button:
			button.pressed.connect(ButtonPressed.bind(button))

	# Define aparência inicial com base em quais skins estão em uso
	update_selected_skin()

	# Desativa visuais se a skin não estiver comprada
	if not PlayerData.skins[1]["purchased"]:
		$Skin2Button/TextureRect/skin2.modulate = Color(0.8, 0.8, 0.8, 0.6)
	if not PlayerData.skins[2]["purchased"]:
		$Skin3Button/TextureRect/skin3.modulate = Color(0.8, 0.8, 0.8, 0.6)


func ButtonPressed(button):
	var selectedTexture = load(pressedText)
	var emptyTexture = load(releasedText)

	match button.name:
		"Skin1Button":
			select_skin(0)

		"Skin2Button":
			if not PlayerData.skins[1]["purchased"]:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[1]["price"]:
					PlayerData.skins[1]["purchased"] = true
					$Skin2Button/TextureRect/skin2.modulate = Color(1, 1, 1, 1)
				else:
					return
			select_skin(1)

		"Skin3Button":
			if not PlayerData.skins[2]["purchased"]:
				if PlayerData.stats["estrelas"] >= PlayerData.skins[2]["price"]:
					PlayerData.skins[2]["purchased"] = true
					$Skin3Button/TextureRect/skin3.modulate = Color(1, 1, 1, 1)
				else:
					return
			select_skin(2)

		"UpgradesButton":
			save_skins()
			get_tree().change_scene_to_file("res://Cenas/hud e menus/Store.tscn")

		"VoltarButton":
			save_skins()
			get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")


func select_skin(index: int):
	for i in range(PlayerData.skins.size()):
		PlayerData.skins[i]["inUse"] = (i == index)

	update_selected_skin()


func update_selected_skin():
	var selectedTexture = load(pressedText)
	var emptyTexture = load(releasedText)

	$Skin1Button/TextureRect.texture = emptyTexture
	$Skin2Button/TextureRect.texture = emptyTexture
	$Skin3Button/TextureRect.texture = emptyTexture

	if PlayerData.skins[0]["inUse"]:
		$Skin1Button/TextureRect.texture = selectedTexture
	if PlayerData.skins[1]["inUse"]:
		$Skin2Button/TextureRect.texture = selectedTexture
	if PlayerData.skins[2]["inUse"]:
		$Skin3Button/TextureRect.texture = selectedTexture

func save_skins():
	SaveManager.update_skins_progress("default", PlayerData.skins[0]["inUse"], true)
	SaveManager.update_skins_progress("skin1", PlayerData.skins[1]["inUse"], PlayerData.skins[1]["purchased"])
	SaveManager.update_skins_progress("skin2", PlayerData.skins[2]["inUse"], PlayerData.skins[2]["purchased"])
