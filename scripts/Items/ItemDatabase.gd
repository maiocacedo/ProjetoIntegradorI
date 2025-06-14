extends Node

# Itens do Jogo
var items = {
	# Chave
	1: {
		"id": 1,
		"name": "Chave",
		"icon": preload("res://Assets/Items/chave_moldura.png"),
		"scene": preload("res://Cenas/items/chave.tscn"),
		"quantity": 1
	},
	# Espada
	2: {
		"id": 2,
		"name": "Espada",
		"icon": preload("res://Assets/Items/espada_moldura.png"),
		"scene": preload("res://Cenas/items/espada.tscn"),
		"quantity": 1
	},
	# Refrigerante
	3: {
		"id": 3,
		"name": "Refrigerante",
		"icon": preload("res://Assets/Items/refrigerante_moldura.png"),
		"scene": preload("res://Cenas/Items/refrigerante.tscn"),
		"quantity": 1
	},
	# Tenis
	4: {
		"id": 4,
		"name": "Tênis",
		"icon": preload("res://Assets/Items/tenis_moldura.png"),
		"scene": preload("res://Cenas/Items/tenis.tscn"),
		"quantity": 1
	}
}

# Retorna o item
func getItem(id):
	return items.get(id, null)
