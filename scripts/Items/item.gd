extends Area2D

# ID
@export var item_id: int
# Nome
@export var item_name: String
# Textura
@export var item_icon: Texture
# Quantidade
@export var quantity: int = 1

# Ao iniciar passa o icone do item para o texture
func _ready():
	$Texture.texture = item_icon

# Quando um corpo entrar em contato com o item (ainda arrumar)
func _on_body_entered(body):
	if body.name == "Player":  # ou use grupo
		var item = {
			"id": item_id,
			"name": item_name,
			"icon": item_icon,
			"quantity": quantity
		}
		var inv = get_tree().get_first_node_in_group("inventory")
		if inv:
			inv.add_item(item)
			queue_free()
