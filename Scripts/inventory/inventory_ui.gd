extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

func _ready():
	verificarUpgrades()  # Verifica os upgrades do player ao iniciar
	add_to_group("inventory")  # Adiciona este nó ao grupo "inventory"
	print("Inventory pronto e grupo adicionado")  # LOG

# Adiciona um item ao inventário
func addItem(item):
	print("Tentando adicionar item ao inventário: " + str(item))  # LOG
	# Tenta empilhar caso o item já exista
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			inventory[i]["quantity"] += item["quantity"]
			updateUI()
			print("Item empilhado no slot " + str(i))  # LOG
			return true
	# Se não existe ainda, adiciona no primeiro slot vazio
	for i in range(len(inventory)):
		if inventory[i] == null:
			inventory[i] = item
			updateUI()
			print("Item adicionado ao slot " + str(i))  # LOG
			return true
	print("Inventário cheio, item não adicionado")  # LOG
	return false

# Remove um item do inventário e dropa no mundo
func removerItem(itemRemover, posicaoDrop):
	print("Tentando remover item: " + str(itemRemover) + " na posição: " + str(posicaoDrop))  # LOG

	# Se não tem espaço na posição de drop, cancela
	if not is_position_free(posicaoDrop):
		show_message("Sem espaço para dropar aqui!")
		print("Drop cancelado: posição ocupada")  # LOG
		return

	# Calcula a posição no chão (um pouco acima)
	var ground_position = get_ground_position(posicaoDrop)
	print("Posição de drop ajustada para o chão: " + str(ground_position))  # LOG

	# Procura o item no inventário
	for i in range(len(inventory)):
		var item = inventory[i]
		if item != null and item["id"] == itemRemover["id"]:
			# Instancia a chave no mundo
			var key_scene = preload("res://Cenas/Items/chave.tscn")
			var key_instance = key_scene.instantiate()
			key_instance.scale = Vector2(0.5, 0.5)
			get_tree().current_scene.add_child(key_instance)
			key_instance.global_position = ground_position
			print("Item droppado na cena")  # LOG

			# Diminui a quantidade ou remove do inventário
			if item["quantity"] > 1:
				item["quantity"] -= 1
				print("Quantidade do item diminuída para: " + str(item["quantity"]))  # LOG
			else:
				inventory[i] = null
				print("Item removido do inventário")  # LOG

			show_message("O(a) " + item["name"] + " foi jogado fora!")
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
	print("Checando espaço livre na posição: " + str(posicao) + " - Livre: " + str(result.is_empty()))  # LOG
	return result.is_empty()

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
		var final_pos = result.position - Vector2(0, 4)  # Sobe 4 pixels para não grudar no chão
		print("Chão encontrado em: " + str(result.position) + ", posição final ajustada: " + str(final_pos))  # LOG
		return final_pos
	else:
		print("Chão não encontrado, mantendo posição original: " + str(start_position))  # LOG
		return start_position

# Mostra uma mensagem com o nome do item
func mostrarNomeItem(slot_index: int):
	if slot_index >= 0 and slot_index < inventory.size():
		var item = inventory[slot_index]
		if item != null:
			show_message(item["name"] + ": " + item["description"])
			print("Mostrando item do slot " + str(slot_index) + ": " + item["name"])  # LOG
		else:
			show_message("Sem Item no Slot.")
			print("Tentou mostrar slot vazio: " + str(slot_index))  # LOG

func _on_touch_button_slot_0_pressed() -> void:
	$HBoxContainer/Slot0/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_pressed.png")
	mostrarNomeItem(0)
	
func _on_touch_button_slot_0_released() -> void:
	$HBoxContainer/Slot0/SlotBackground.texture = load("res://Assets/Inventory/slot_inv.png")

func _on_touch_button_slot_1_pressed() -> void:
	$HBoxContainer/Slot1/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_pressed.png")
	mostrarNomeItem(1)
	
func _on_touch_button_slot_1_released() -> void:
	$HBoxContainer/Slot1/SlotBackground.texture = load("res://Assets/Inventory/slot_inv.png")

func _on_touch_button_slot_2_pressed() -> void:
	$HBoxContainer/Slot2/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_pressed.png")
	mostrarNomeItem(2)
	
func _on_touch_button_slot_2_released() -> void:
	$HBoxContainer/Slot2/SlotBackground.texture = load("res://Assets/Inventory/slot_inv.png")

# Quando o botão do slot 3 (especificopara chave) for pressionado
func _on_touch_button_slot_3_pressed() -> void:
	$HBoxContainer/Slot3/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_chave_pressed.png")
	var player = get_tree().get_first_node_in_group("player")
	if player != null:
		var drop_offset = player.facingDir.normalized() * 16
		var drop_position = player.global_position + drop_offset
		print("Botão pressionado - Drop na posição: " + str(drop_position))  # LOG
		if getQtdItem(ItemDB.getItem(1)) == 0:
			show_message("Sem Chave no Slot.")
		else:
			removerItem(ItemDB.getItem(1), drop_position)
	else:
		print("Player não encontrado no drop (pressed)")  # LOG

# Quando o botão do slot 3 (especificopara chave) for solto
func _on_touch_button_slot_3_released() -> void:
	$HBoxContainer/Slot3/SlotBackground.texture = load("res://Assets/Inventory/slot_inv_chave.png")
	print("Botão de drop solto")  # LOG		
