extends CharacterBody2D

var stats = {
	"speed": 200.0,
	"jumpSpeed": -300.0,
	"dano": 0,
	"vida": 1
}

@export var inv: Inv

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var hasSpeedUpgrade: bool = false
var speedUpgradeApplied: bool = false

var hasDamageUpgrade: bool = false
var hasDialogo: bool = false
var hasEspada: bool = false
var damageUpgradeApplied: bool = false

var hasJumpUpgrade: bool = false
var jumpUpgradeApplied: bool = false

var hasPergaminho: bool = false
var pergaminhoUsado: bool = false

var speedUpgradeScript := preload("res://Upgrades.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://DamageUpgrade.gd").new()
var jumpUpgradeScript := preload("res://JumpUpgrade.gd").new()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = stats["jumpSpeed"]
		audio_stream_player_2d.playing = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("esquerda", "direita")
	
	
	# animações
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("parado")
		else:
			animated_sprite_2d.play("corre")
	else:
		animated_sprite_2d.play("pula")
		
	
	#virar personagem
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# direção para onde corre
	if direction:
		velocity.x = direction * stats["speed"]
	else:
		velocity.x = move_toward(velocity.x, 0, stats["speed"])
		
	if Input.is_action_just_pressed("e") and stats["dano"] > 0: #ele impede que seja feito o ataque caso não tenha dano
		#aqui vai a lógica de ataque, mas enquanto não é feito, deixei um print para debug, para mostrar o buff funcionando
		print("deu ", stats["dano"], " de dano")

	if Input.is_action_just_pressed("f1"): #aplica o upgrade de velocidade
		hasSpeedUpgrade = !hasSpeedUpgrade #muda para true que tem o upgrade
	
	if not damageUpgradeApplied: #impede que seja aplicado o buff mais de 1 vez
		ApplyUpgrade(damageUpgradeScript)
		
	ApplyUpgrade(speedUpgradeScript) #aplica o buff de velocidade
	
	if Input.is_action_just_pressed("f2"): #upgrade dialogo
		hasDialogo = !hasDialogo #ativa o buff
		damageUpgradeScript.damageBonus = 5 #define o bonus de dano

	if Input.is_action_just_pressed("f3"): #upgrade espada apc
		hasEspada = !hasEspada #ativa o buff
		damageUpgradeScript.damageBonus = 10 #define o bonus de dano
		
	if Input.is_action_just_pressed("f4"):
		hasJumpUpgrade = !hasJumpUpgrade #ativa o buff
		
	ApplyUpgrade(jumpUpgradeScript) #aplica o buff
	
	if Input.is_action_just_pressed("f5"):
		hasPergaminho = hasPergaminho
		
	

	move_and_slide()

func collect(item):
	inv.insert(item)
	
	
func ApplyUpgrade(upgradeScript): #método para ser utilizado no molde
	upgradeScript.Aplicar(stats, self) #chama o método da outra classe
