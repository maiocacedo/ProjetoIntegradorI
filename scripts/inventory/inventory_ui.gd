extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

# Função que adicionará os itens desejados ao inicio
func _ready():
	#var item = ItemDB.getItem(1) # Obtem o item espada pelo banco de dados
	#var item2 = ItemDB.getItem(2) # Obtem o item espada pelo banco de dados
	#addItem(item)
	#addItem(item2)
	#updateUI()
	add_to_group("inventory")

# Adiciona um determinado item no inventário
func addItem(item):
	for i in range(len(inventory)):
		if inventory[i] == null:
			inventory[i] = item
			updateUI()
			return true
	return false

# Remove um determinado item no inventário por index
func removeItem(slotIndex):
	if slotIndex >= 0 and slotIndex < len(inventory):
		inventory[slotIndex] = null

# Atualiza os slots do inventário
func updateUI():
	for i in range(len(inventory)):
		var slotBg = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotBackground")  
		var slotItem = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotItem")  
		var item = inventory[i]
		if item != null:
			slotItem.texture = item["icon"]
			slotItem.visible = true
		else:
			slotItem.visible = false
