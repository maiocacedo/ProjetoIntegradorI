extends Node

var stats = { #guarda informações do player
	"speed": 200.0,
	"jumpSpeed": -300.0,
	"estrelas": 0
}

var skins = [ #guarda informações das skins
	{"name": "Default" , "price": 0 , "inUse": true},
	{"name": "Skin1" , "price": 10 , "inUse": false},
	{"name": "Skin2" , "price": 20 , "inUse": false},
	{"name": "Skin3" , "price": 30 , "inUse": false}
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
