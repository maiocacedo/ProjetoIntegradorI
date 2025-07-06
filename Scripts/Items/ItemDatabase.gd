extends Node

# Itens do Jogo
var items = {
	# Chave
	1: {
		"id": 1,
		"name": "Chave",
		"description": "Usa-se para abrir portas!",
		"icon": preload("res://Assets/Items/chave_moldura.png"),
		"scene": preload("res://Cenas/items/chave.tscn"),
		"quantity": 1
	},
	# Refrigerante
	2: {
		"id": 2,
		"name": "Refri Pulante",
		"description": "Ele deixa seu pulo mais alto!",
		"icon": preload("res://Assets/Items/refrigerante_moldura.png"),
		"scene": preload("res://Cenas/Items/refrigerante.tscn"),
		"quantity": 1
	},
	# Tenis
	3: {
		"id": 3,
		"name": "Tênis Veloz",
		"description": "Você fica mais rápido com ele!",
		"icon": preload("res://Assets/Items/tenis_moldura.png"),
		"scene": preload("res://Cenas/Items/tenis.tscn"),
		"quantity": 1
	},
	# Escudo
	4: {
		"id": 4,
		"name": "Escudo",
		"description": "Você tem uma vida a mais!",
		"icon": preload("res://Assets/Items/escudo_moldura.png"),
		"scene": preload("res://Cenas/Items/escudo.tscn"),
		"quantity": 1
	},
	# Escudo com Espinhos
	5: {
		"id": 5,
		"name": "Faquinha",
		"description": "Permite derrotar um inimigo!",
		"icon": preload("res://Assets/Items/faquinha_moldura.png"),
		"scene": preload("res://Cenas/Items/faquinha.tscn"),
		"quantity": 1
	}
}

# Retorna o item
func getItem(id):
	return items.get(id, null)
