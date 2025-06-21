extends Node2D

@export var sprite_esquerda: Texture2D
@export var sprite_direita: Texture2D

@export var estado: int = 0  # 0 = esquerda, 1 = direita
@onready var sprite = $SpriteAlavanca

func _ready():
	atualizar_visual()
	$DetectorColisao.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("So para  testar", body.name)
	if body.name == "CharacterBody2D": 
		alternar_estado()

func alternar_estado():
	estado = 1 - estado
	atualizar_visual()
	print("Estado da alavanca:", estado)

func atualizar_visual():
	if estado == 0:
		sprite.texture = sprite_esquerda
	else:
		sprite.texture = sprite_direita
