extends Node

@onready var playerLabel = $PlayerLabel

var speedUpgradeScript := preload("res://Scripts/upgrades/SpeedUpgrade.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://Scripts/upgrades/DamageUpgrade.gd").new() #referencia ao script de upgrade de dano
var jumpUpgradeScript := preload("res://Scripts/upgrades/JumpUpgrade.gd").new() #referencia ao script de upgrade de pulo
var pergaminhoScript := preload("res://Scripts/upgrades/LifeUpgrade.gd").new() #referencia ao sript do pergaminho

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	playerLabel.text = " x" + str(PlayerData.stats["estrelas"])
