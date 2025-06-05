extends Control

var inventory = [null, null, null, null]  # 3 slots vazios

func _ready():
	# Exemplo: adiciona 1 item para teste
	# add_item({"id": "potion", "name": "Poção de Vida", "quantity": 1})
	update_ui()

# Função para adicionar item no primeiro slot vazio
func add_item(item):
	for i in range(len(inventory)):
		if inventory[i] == null:
			inventory[i] = item
			return true
	return false

# Função para remover item de um slot
func remove_item(slot_index):
	if slot_index >= 0 and slot_index < len(inventory):
		inventory[slot_index] = null

# Atualiza texto dos botões com nome do item ou “Vazio”
func update_ui():
	for i in range(3):
		var btn = $HBoxContainer.get_node("Slot%d" % i)
		if inventory[i] != null:
			btn.text = inventory[i]["name"] + " x" + str(inventory[i]["quantity"])
		else:
			btn.text = "Vazio"

# Função chamada quando um slot é clicado
func _on_Slot_pressed(slot_index):
	if inventory[slot_index] != null:
		print("Usou o item: ", inventory[slot_index]["name"])
		# Exemplo: ao usar remove o item
		remove_item(slot_index)
		update_ui()
	else:
		print("Slot vazio")

func _on_slot_0_pressed() -> void:
	_on_Slot_pressed(0)

func _on_slot_1_pressed() -> void:
	_on_Slot_pressed(1)

func _on_slot_2_pressed() -> void:
	_on_Slot_pressed(2)

func _on_slot_3_pressed() -> void:
	_on_Slot_pressed(3)
