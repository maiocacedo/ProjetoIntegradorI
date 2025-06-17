extends Node

@onready var playerLabel = $PlayerLabel


var speedUpgradeScript := preload("res://Assets/Scripts/SpeedUpgrade.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://Assets/Scripts/DamageUpgrade.gd").new() #referencia ao script de upgrade de dano
var jumpUpgradeScript := preload("res://Assets/Scripts/JumpUpgrade.gd").new() #referencia ao script de upgrade de pulo
var pergaminhoScript := preload("res://Assets/Scripts/LifeUpgrade.gd").new() #referencia ao sript do pergaminho

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playerLabel.text = "Dinheiro: " + str(PlayerData.stats["estrelas"])
	
