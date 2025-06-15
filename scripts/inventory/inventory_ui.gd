extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

# Fila de mensagens
var message_queue = []
var showing_message = false

func _ready():
	verificarUpgrades()
	add_to_group("inventory")

# Adiciona um determinado item no inventário
func addItem(item):
	print("Adicionando item...")
	# Verifica se o item já existe no inventário
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			inventory[i]["quantity"] += item["quantity"]
			updateUI()
			return true

	# Caso não exista, adiciona no primeiro slot vazio
	for i in range(len(inventory)):
		if inventory[i] == null:
			inventory[i] = item
			updateUI()
			return true

	return false

# Remove determinado item do inventário de acordo com o ID passado
func removeItem(itemRemover, quantidade=1):
	print("Removendo item...") # LOG
	for i in range(len(inventory)):
		var item = inventory[i]
		if item != null and item["id"] == itemRemover["id"]:
			if item["quantity"] > quantidade:
				item["quantity"] -= quantidade
			else:
				inventory[i] = null
			updateUI()
			return

# Retorna a quantidade de um determinado item no inventário
func getQtdItem(item):
	print("Obtendo quantidade do item solicitado:") # LOG
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i]["id"] == item["id"]:
			print(str(inventory[i]["quantity"])) # LOG
			return inventory[i]["quantity"]
	print("não encontrado") # LOG
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
			slotItem.visible = false
			slotQtd.visible = false

# Verifica quais upgrades o player tem e adiciona ao inventário
func verificarUpgrades():
	var player = get_tree().get_first_node_in_group("player")
	
	print("Verificando se player é null:") # LOG
	if player != null:
		print("não é, tudo certo!") # LOG
		var upgrades = []

		# Se o Refri Pulante estiver equipado
		if player.hasRefrigerante:
			addItem(ItemDB.getItem(2))
			upgrades.append(ItemDB.getItem(2)["name"])
		
		# Se o Tenis Veloz estiver equipado
		if player.hasTenis:
			addItem(ItemDB.getItem(3))
			upgrades.append(ItemDB.getItem(3)["name"])
		
		# Se o Escudo estiver equipado
		if player.hasEscudo:
			addItem(ItemDB.getItem(4))
			upgrades.append(ItemDB.getItem(4)["name"])
		
		# Se o Escudo com Espinhos estiver equipado
		if player.hasEscudoEspinhos:
			addItem(ItemDB.getItem(5))
			upgrades.append(ItemDB.getItem(5)["name"])
		
		if upgrades.size() > 0:
			var texto_final = ", ".join(upgrades) + " equipado(s)!"
			show_message(texto_final)
			$AudioPowerUp.playing = true
	else:
		print("Adicione o player ao grupo \"player\"") # LOG

# Mostra uma mensagem na label info do inv
func show_message(text):
	print("mostrando msg") # LOG
	message_queue.append(text)
	if not showing_message:
		print("prox mensagem") # LOG
		_process_next_message()

# Caso tenha mais de uma mensagem a ser mostrada
func _process_next_message():
	if message_queue.size() == 0:
		showing_message = false
		return

	showing_message = true
	var text = message_queue.pop_front()
	$LabelInfo.text = text
	$LabelInfo.visible = true
	$TimerInfo.start()  # Tempo configurado no editor, tipo 2 segundos

# Apos o tempo de mensagem acabar
func _on_timer_info_timeout() -> void:
	print("time out") # LOG
	$LabelInfo.visible = false
	_process_next_message()
