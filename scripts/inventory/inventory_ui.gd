extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

# Função que adicionará os itens desejados ao inicio
func _ready():
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
func removeItem(itemID, quantidade=1): # quantidade -> diminui a qtd antes de realmente remover (até zerar)
	for i in range(len(inventory)):
		var item = inventory[i]
		if item != null and item["id"] == itemID:
			if item["quantity"] > quantidade:
				item["quantity"] -= quantidade
			else:
				inventory[i] = null
			updateUI()
			return

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
