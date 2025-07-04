extends Node2D

@export var sprite_esquerda: Texture2D
@export var sprite_direita: Texture2D

@export var estado: int = 0  # 0 = esquerda, 1 = direita
@onready var sprite = $SpriteAlavanca

var ativada: bool = false

func _ready():
	atualizar_visual()
	add_to_group("alavanca")  # Para a porta poder encontrar essa alavanca
	$DetectorColisao.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Só para testar", body.name)
	if body.is_in_group("player"): 
		alternar_estado()
		if estado == 1:
			for plataforma in get_tree().get_nodes_in_group("bloqueio_porta"):
				plataforma.visible = false
				var colisor = plataforma.get_node_or_null("CollisionShape2D")
				if colisor:
					colisor.set_deferred("disabled", true)
				if plataforma.has_method("set_deferred"):
						plataforma.set_deferred("disabled", true)

func alternar_estado():
	estado = 1 - estado
	atualizar_visual()
	
	# Define ativada conforme o estado
	ativada = estado == 1
	
	print("Estado da alavanca:", estado)
	print("Alavanca ativada:", ativada)

func atualizar_visual():
	if estado == 0:
		sprite.texture = sprite_esquerda
	else:
		sprite.texture = sprite_direita
