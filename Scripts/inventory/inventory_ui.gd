extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

func _ready():
	verificarUpgrades()
	add_to_group("inventory")

# Adiciona um determinado item no inventário
func addItem(item):
	print("Adicionando item...")
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			inventory[i]["quantity"] += item["quantity"]
			updateUI()
			return true
	for i in range(len(inventory)):
		if inventory[i] == null:
			inventory[i] = item
			updateUI()
			return true
	return false

# Remove determinado item do inventário de acordo com o ID passado
func removerItem(itemRemover, posicaoDrop):
	print("Removendo item...") # LOG
	for i in range(len(inventory)):
		var item = inventory[i]
		if item != null and item["id"] == itemRemover["id"]:
			if item["quantity"] > 1:
				item["quantity"] -= 1
			else:
				inventory[i] = null

			show_message("O(a) " + item["name"] + " foi jogado fora!")
			
			var key_scene = preload("res://Cenas/Items/chave.tscn")
			var key_instance = key_scene.instantiate()
			key_instance.scale = Vector2(0.5, 0.5)
			get_tree().current_scene.add_child(key_instance)
			key_instance.global_position = posicaoDrop
			
			updateUI()
			return

# Retorna a quantidade de um determinado item no inventário
func getQtdItem(item):
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			return inventory[i]["quantity"]
	return 0

# Atualiza os slots do inventário
func updateUI():
	for i in range(len(inventory)):
		var slotBg = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotBackground")
		var slotItem = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotItem")
		var slotQtd = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotQtd")
		var item = inventory[i]
		if item != null:
			slotItem.texture = item["icon"]
			slotItem.visible = true
			if item["quantity"] > 1:
				slotQtd.text = str(item["quantity"])
				slotQtd.visible = true
			else:
				slotQtd.text = ""
				slotQtd.visible = false
		else:
			slotItem.visible = false
			slotQtd.visible = false

# Verifica quais upgrades o player tem
func verificarUpgrades():
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		var upgrades = []
		if player.hasRefrigerante or PlayerData.hasJumpUpgrade:
			addItem(ItemDB.getItem(2))
			upgrades.append(ItemDB.getItem(2)["name"])
		if player.hasTenis or PlayerData.hasSpeedUpgrade:
			addItem(ItemDB.getItem(3))
			upgrades.append(ItemDB.getItem(3)["name"])
		if player.hasEscudo or PlayerData.hasPergaminho:
			addItem(ItemDB.getItem(4))
			upgrades.append(ItemDB.getItem(4)["name"])
		if player.hasEscudoEspinhos or PlayerData.hasDamageUpgrade:
			addItem(ItemDB.getItem(5))
			upgrades.append(ItemDB.getItem(5)["name"])
		if upgrades.size() > 0:
			show_message(", ".join(upgrades) + " equipado(s)!")
			$AudioPowerUp.playing = true
	else:
		print("Adicione o player ao grupo \"player\"") # LOG

# Mostra uma mensagem simples
func show_message(text):
	$LabelInfo.text = text
	$LabelInfo.visible = true
	$TimerInfo.start()  # Temporizador para esconder a mensagem depois de alguns segundos

# Ao terminar o tempo da mensagem
func _on_timer_info_timeout() -> void:
	$LabelInfo.visible = false

# Função que remove a chave ao pressionar
func _on_touch_screen_button_pressed() -> void:
	$HBoxContainer/Slot3/SlotBackground.texture = load("res://Assets/Inventory/slot-inv.png")
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		print("Droppando item (touch)")
		var drop_offset = player.facingDir * 16
		var drop_position = player.global_position + drop_offset
		removerItem(ItemDB.getItem(1), drop_position)
	else:
		print("Problema ao dropar item, player não encontrado")

func _on_touch_screen_button_released() -> void:
	$HBoxContainer/Slot3/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_chave.png")
