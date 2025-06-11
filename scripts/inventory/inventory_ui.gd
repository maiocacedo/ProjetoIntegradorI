extends Control

# Inventário com 4 Slots
var inventory = [null, null, null, null]

# Função que adicionará os itens desejados ao inicio
func _ready():
	var item = ItemDB.get_item(1) # Obtem o item espada pelo banco de dados
	add_item(item)
	update_ui()

# Adiciona um determinado item no inventário
func add_item(item):
	for i in range(len(inventory)):
		if inventory[i] == null:
			inventory[i] = item
			return true
	return false

# Remove um determinado item no inventário por index
func remove_item(slot_index):
	if slot_index >= 0 and slot_index < len(inventory):
		inventory[slot_index] = null

# Atualiza os slots do inventário
func update_ui():
	for i in range(len(inventory)):
		var slot_bg = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotBackground")  
		var btn = $HBoxContainer.get_node("Slot%d" % i).get_node("SlotButton")  
		var item = inventory[i]
		if item != null:
			btn.icon = item["icon"]
			btn.visible = true
		else:
			btn.visible = false

# Função chamada quando algum slot é pressionado (talvez retirar)
func _on_Slot_pressed(slot_index):
	if inventory[slot_index] != null:
		print("Usou o item: ", inventory[slot_index]["name"])
		remove_item(slot_index)
		update_ui()
	else:
		print("Slot vazio")

# Slot 0
func _on_slot_0_pressed() -> void:
	_on_Slot_pressed(0)

# Slot 1
func _on_slot_1_pressed() -> void:
	_on_Slot_pressed(1)

# Slot 2
func _on_slot_2_pressed() -> void:
	_on_Slot_pressed(2)

# Slot 3
func _on_slot_3_pressed() -> void:
	_on_Slot_pressed(3)
