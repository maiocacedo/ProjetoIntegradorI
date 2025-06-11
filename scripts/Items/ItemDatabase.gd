extends Node

# Itens do Jogo
var items = {
	# Espada
	1: {
		"id": 1,
		"name": "Espada",
		"icon": preload("res://Assets/items/espada_32x32.png"),
		"scene": preload("res://Cenas/items/espada.tscn"),
		"quantity": 1
	}
	# Adicionar...
}

# Retorna o item
func get_item(id):
	return items.get(id, null)
