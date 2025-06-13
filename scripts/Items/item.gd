extends Area2D

# ID
@export var itemId: int
# Nome
@export var itemName: String
# Textura
@export var itemIcon: Texture
# Quantidade
@export var quantity: int = 1

# Ao iniciar passa o icone do item para o texture
func _ready():
	add_to_group("player")
	$Texture.texture = itemIcon
	$Texture.visible = true
	$Animation.play("idle")

# Quando um corpo entrar em contato com o item (ainda arrumar)
func _on_body_entered(body):
	print("Entrou em contato com:", body.name)
	if body.is_in_group("player"):  
		var item = {
			"id": itemId,
			"name": itemName,
			"icon": itemIcon,
			"quantity": quantity
		}
		var inv = get_tree().get_first_node_in_group("inventory")
		if inv == null:
			print("Inventário não encontrado no grupo")
		else:
			print("Inventário encontrado:", inv)
			inv.addItem(item)
			$AudioColetado.play()
			$Animation.play("collect")

# Quando a animação finaliza
func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "collect":
		$Collision.disabled = true
		$Texture.visible = false
		queue_free()
