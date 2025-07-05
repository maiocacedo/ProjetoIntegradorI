extends Node

var stats = { #guarda informações do player
	"speed": 300.0,
	"jumpSpeed": -300.0,
	"estrelas": 0
}

var skins = [ #guarda informações das skins
	{"name": "default" , "price": 0 , "inUse": true},
	{"name": "skin1" , "price": 15 , "inUse": false, "purchased": false},
	{"name": "skin2" , "price": 30 , "inUse": false, "purchased": false},
]

#aqui vai as variaveis relacionadas ao player

var hasSpeedUpgrade: bool = false
var speedUpgradeApplied: bool = false

var hasDamageUpgrade: bool = false
var damageUpgradeApplied: bool = false

var hasJumpUpgrade: bool = false
var jumpUpgradeApplied: bool = false

var hasPergaminho: bool = false
var pergaminhoUsado: bool = false

func ResetVariables() -> void: #aqui reseta as variaveis de uso para evitar mal funcionamento
	#aqui coloca as variaveis de uso
	speedUpgradeApplied = false
	damageUpgradeApplied = false
	jumpUpgradeApplied = false
	pergaminhoUsado = false
	stats["speed"] = 300
	stats["jumpSpeed"] = -300
