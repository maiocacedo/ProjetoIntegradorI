extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

# Função que adicionará os itens desejados ao inicio
func _ready():
	verificarUpgrades()
	add_to_group("inventory")

# Adiciona um determinado item no inventário
func addItem(item):
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
func removeItem(itemRemover, quantidade=1): # quantidade -> diminui a qtd antes de realmente remover (até zerar)
	print("Removendo item...")
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
			slotItem.visible = false
			slotQtd.visible = false

# ---------------------------- REVER AO IMPLEMENTAR --------------------------------
# Verifica atraves do Nó Player quais upgrades ele possui para adicionar ao inv
func verificarUpgrades():
	var player = get_tree().get_first_node_in_group("player")
	#if player.hasEspada
		#addItem(ItemDB.getItem(1))
	#
	#if player.hasRefrigerante
		#addItem(ItemDB.getitem(3))
	#
	#if player.hasTenis
		#addItem(ItemDB.getitem(4))
