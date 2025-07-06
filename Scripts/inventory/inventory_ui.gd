extends Control

# Inventário com 4 Slots (0 a 2 = upgrades | 3 = chave)
var inventory = [null, null, null, null]

func _ready():
	add_to_group("inventory")  # Adiciona este nó ao grupo "inventory"
	print("Inventory pronto e grupo adicionado")  # LOG

# Adiciona um item ao inventário
func addItem(item):
	print("Tentando adicionar item ao inventário: " + str(item))  # LOG

	if item["id"] == 1:
		# Chave só pode ir no slot 3
		var i = 3
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			inventory[i]["quantity"] += item["quantity"]
			print("Chave empilhada no slot 3")  # LOG
		else:
			inventory[i] = item
			print("Chave adicionada ao slot 3")  # LOG
		updateUI()
		return true
	else:
		# Upgrades: tenta empilhar nos slots 0 a 2
		for i in range(3):
			if inventory[i] != null and inventory[i]["id"] == item["id"]:
				inventory[i]["quantity"] += item["quantity"]
				print("Upgrade empilhado no slot " + str(i))  # LOG
				updateUI()
				return true
		# Se não tem, coloca no primeiro slot vazio entre 0 a 2
		for i in range(3):
			if inventory[i] == null:
				inventory[i] = item
				print("Upgrade adicionado ao slot " + str(i))  # LOG
				updateUI()
				return true

	print("Sem espaço para adicionar item")  # LOG
	return false

# Remove um item do inventário e dropa no mundo
func removerItem(itemRemover, posicaoDrop):
	print("Tentando remover item: " + str(itemRemover) + " na posição: " + str(posicaoDrop))  # LOG

	# Procura o item no inventário
	for i in range(inventory.size()):
		var item = inventory[i]
		if item != null and item["id"] == itemRemover["id"]:
			
			# Se for o slot da chave (slot 3), faz o drop normalmente
			if i == 3:
				if not is_position_free(posicaoDrop):
					show_message("Sem espaço para dropar aqui!")
					print("Drop cancelado: posição ocupada")  # LOG
					return

				var ground_position = get_ground_position(posicaoDrop)
				print("Posição de drop ajustada para o chão: " + str(ground_position))  # LOG

				var key_scene = preload("res://Cenas/Items/chave.tscn")
				var key_instance = key_scene.instantiate()
				key_instance.scale = Vector2(2, 2)
				get_tree().current_scene.add_child(key_instance)
				key_instance.global_position = ground_position
				print("Item droppado na cena")  # LOG
			else:
				print("Item não será droppado pois não está no slot da chave")  # LOG

			# Diminui a quantidade ou remove do inventário
			if item["quantity"] > 1:
				item["quantity"] -= 1
				print("Quantidade do item diminuída para: " + str(item["quantity"]))  # LOG
			else:
				inventory[i] = null
				print("Item removido do inventário")  # LOG

			show_message("O(a) " + item["name"] + " foi utilizado(a)!")
			$AudioDrop.playing = true
			updateUI()
			return

	print("Item não encontrado no inventário")  # LOG
# Retorna a quantidade de um determinado item no inventário
func getQtdItem(item):
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			print("Quantidade do item encontrada: " + str(inventory[i]["quantity"]))  # LOG
			return inventory[i]["quantity"]
	print("Item não encontrado no inventário")  # LOG
	return 0

# Atualiza a interface dos slots do inventário
func updateUI():
	print("Atualizando UI do inventário...")  # LOG
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
	print("UI atualizada")  # LOG

# Verifica quais upgrades o player já possui
func verificarUpgrades():
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		var upgrades = []

		if player.hasRefrigerante:
			addItem(ItemDB.getItem(2))
			upgrades.append(ItemDB.getItem(2)["name"])

		if player.hasTenis:
			addItem(ItemDB.getItem(3))
			upgrades.append(ItemDB.getItem(3)["name"])

		if player.hasEscudo:
			addItem(ItemDB.getItem(4))
			upgrades.append(ItemDB.getItem(4)["name"])

		if player.hasEscudoEspinhos:
			addItem(ItemDB.getItem(5))
			upgrades.append(ItemDB.getItem(5)["name"])

		if upgrades.size() > 0:
			show_message(", ".join(upgrades) + " equipado(s)!")
			$AudioPowerUp.playing = true
			print("Upgrades adicionados: " + str(upgrades))  # LOG
	else:
		print("Player não encontrado no grupo 'player'")  # LOG

# Exibe uma mensagem temporária na tela
func show_message(text):
	$LabelInfo.text = text
	$LabelInfo.visible = true
	$TimerInfo.start()
	print("Mensagem exibida: " + text)  # LOG

# Callback do timer para esconder a mensagem
func _on_timer_info_timeout() -> void:
	$LabelInfo.visible = false
	print("Mensagem oculta após timeout")  # LOG

# Checa se a posição está livre para dropar um item
func is_position_free(posicao: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsPointQueryParameters2D.new()
	params.position = posicao
	params.collide_with_areas = true
	params.collide_with_bodies = true
	var result = space_state.intersect_point(params)

	# Filtrar os objetos que ocupam o espaço
	for hit in result:
		var collider = hit.get("collider")
		if collider != null:
			if collider.is_in_group("chave"):
				print("Espaço ocupado, mas é uma chave. Permitido.")  # LOG
				continue
			else:
				print("Espaço ocupado por: " + str(collider))  # LOG
				return false

	print("Espaço livre ou só com chaves")  # LOG
	return true

# Faz um raycast para encontrar o chão mais próximo abaixo
func get_ground_position(start_position: Vector2) -> Vector2:
	var space_state = get_world_2d().direct_space_state
	var ray_length = 100  # Distância máxima da busca para baixo

	var query = PhysicsRayQueryParameters2D.new()
	query.from = start_position
	query.to = start_position + Vector2(0, ray_length)
	query.exclude = [self, get_tree().get_first_node_in_group("player")]

	var result = space_state.intersect_ray(query)

	if result:
		var final_pos = result.position - Vector2(0, 10)  # Sobe 10 pixels para não grudar no chão
		print("Chão encontrado em: " + str(result.position) + ", posição final ajustada: " + str(final_pos))  # LOG
		return final_pos
	else:
		print("Chão não encontrado, mantendo posição original: " + str(start_position))  # LOG
		return start_position

# Mostra uma mensagem com o nome e descrição do item
func mostrarNomeItem(slot_index: int):
	if slot_index >= 0 and slot_index < inventory.size():
		var item = inventory[slot_index]
		if item != null:
			show_message(item["name"] + ": " + item["description"])
			print("Mostrando item do slot " + str(slot_index) + ": " + item["name"])  # LOG
		else:
			show_message("Sem Item no Slot.")
			print("Tentou mostrar slot vazio: " + str(slot_index))  # LOG

# Ações para o slot 0
func _on_touch_button_slot_0_pressed() -> void:
	$AudioSlotClick.playing = true
	$HBoxContainer/Slot0/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_pressed.png")
	mostrarNomeItem(0)

func _on_touch_button_slot_0_released() -> void:
	$HBoxContainer/Slot0/SlotBackground.texture = load("res://Assets/Inventory/slot_inv.png")

# Ações para o slot 1
func _on_touch_button_slot_1_pressed() -> void:
	$AudioSlotClick.playing = true
	$HBoxContainer/Slot1/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_pressed.png")
	mostrarNomeItem(1)

func _on_touch_button_slot_1_released() -> void:
	$HBoxContainer/Slot1/SlotBackground.texture = load("res://Assets/Inventory/slot_inv.png")

# Ações para o slot 2
func _on_touch_button_slot_2_pressed() -> void:
	$AudioSlotClick.playing = true
	$HBoxContainer/Slot2/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_pressed.png")
	mostrarNomeItem(2)

func _on_touch_button_slot_2_released() -> void:
	$HBoxContainer/Slot2/SlotBackground.texture = load("res://Assets/Inventory/slot_inv.png")

# Quando o botão do slot 3 (chave) for pressionado
func _on_touch_button_slot_3_pressed() -> void:
	$HBoxContainer/Slot3/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_chave_pressed.png")
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		var drop_offset = player.facingDir.normalized() * 40
		var drop_position = player.global_position + drop_offset
		print("Botão pressionado - Drop na posição: " + str(drop_position))  # LOG
		if getQtdItem(ItemDB.getItem(1)) == 0:
			show_message("Sem Chave no Slot.")
			$AudioSlotClick.playing = true
		else:
			removerItem(ItemDB.getItem(1), drop_position)
	else:
		print("Player não encontrado no drop (pressed)")  # LOG

# Quando o botão do slot 3 (chave) for solto
func _on_touch_button_slot_3_released() -> void:
	$HBoxContainer/Slot3/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_chave.png")
	print("Botão de drop solto")  # LOG
