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
