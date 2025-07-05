extends CharacterBody2D

var SPEED: float
const ACCELERATION = 900.0
const FRICTION = 900.0
var JUMP_VELOCITY: float
const EXTRA_GRAVITY = 800.0

const COYOTE_TIME = 0.15
const JUMP_BUFFER_TIME = 0.1

var alive = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speedUpgradeScript := preload("res://Scripts/upgrades/SpeedUpgrade.gd").new()
var damageUpgradeScript := preload("res://Scripts/upgrades/DamageUpgrade.gd").new()
var jumpUpgradeScript := preload("res://Scripts/upgrades/JumpUpgrade.gd").new()

@export var hasRefrigerante: bool
@export var hasTenis: bool
@export var hasEscudo: bool
@export var hasEscudoEspinhos: bool

var currentskin: SpriteFrames
var default: SpriteFrames = load("res://Cenas/player/playerdefault.tres") 
var skin1: SpriteFrames = load("res://Cenas/player/playerskin1.tres")
var skin2: SpriteFrames = load("res://Cenas/player/playerskin2.tres")

var knockbackHorizontal = 800
var knockbackVertical = -300

var jumpsLeft = 2
var facingDir := Vector2.RIGHT

# Físicas avançadas
var coyoteTimer = 0.0
var jumpBufferTimer = 0.0
var knockbackTime = 0.0
const KNOCKBACK_DURATION = 0.3

# Controle de animação de pulo
var has_jumped = false

# Verifica os upgrades
func _ready() -> void:
	PlayerData.ResetVariables()
	if PlayerData.hasJumpUpgrade:
		hasRefrigerante = true
	if PlayerData.hasSpeedUpgrade:
		hasTenis = true
	if PlayerData.hasDamageUpgrade:
		hasEscudoEspinhos = true
	if PlayerData.hasPergaminho:
		hasEscudo = true
	
	ApplyUpgrade(speedUpgradeScript)
	SPEED = PlayerData.stats["speed"]
	
	ApplyUpgrade(jumpUpgradeScript)
	JUMP_VELOCITY = PlayerData.stats["jumpSpeed"]
	
	var inventory = get_tree().get_first_node_in_group("inventory")
	
	inventory.verificarUpgrades()
	
	for skin in PlayerData.skins:
		if skin["inUse"]:
			
			if skin["name"] == "default":
				currentskin = default
			if skin["name"] == "skin1":
				currentskin = skin1
			if skin["name"] == "skin2":
				currentskin = skin2
	
	animated_sprite_2d.sprite_frames = currentskin

func _physics_process(delta: float) -> void:
	if not alive:
		if animated_sprite_2d.animation != "die":
			animated_sprite_2d.play("die")
		return
		

	# Temporizadores
	if not is_on_floor():
		coyoteTimer -= delta
	else:
		coyoteTimer = COYOTE_TIME
		jumpsLeft = 2
		has_jumped = false  # Reset do pulo ao tocar o chão

	jumpBufferTimer -= delta
	knockbackTime -= delta

	if Input.is_action_just_pressed("pular"):
		jumpBufferTimer = JUMP_BUFFER_TIME

	# Gravidade extra
	if not is_on_floor() and velocity.y < 500:
		velocity.y += EXTRA_GRAVITY * delta

	# Pulo com coyote e buffer
	if jumpBufferTimer > 0 and (jumpsLeft > 0 or coyoteTimer > 0):
		velocity.y = JUMP_VELOCITY
		jump.playing = true
		jumpBufferTimer = 0
		jumpsLeft -= 1
		has_jumped = true  # Seta que pulou

	# Direção
	var direction := Input.get_axis("esquerda", "direita")

	# Atualiza direção de virada
	if abs(velocity.x) > 0.1:
		facingDir = Vector2.RIGHT if velocity.x > 0 else Vector2.LEFT

	# Movimento horizontal com aceleração
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	# Knockback tem prioridade
	if knockbackTime > 0:
		move_and_slide()
		return

	# Movimento do personagem
	move_and_slide()

	# Animações
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("parado")
		else:
			animated_sprite_2d.play("corre")
	elif has_jumped:
		animated_sprite_2d.play("pula")
		has_jumped = false  # Toca a animação só uma vez

	# Espelhamento do sprite
	animated_sprite_2d.flip_h = (facingDir == Vector2.LEFT)

	# Interações com plataformas
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)

func die() -> void:
	$AudioMorte.playing = true
	alive = false

func collect(item):
	pass

func ApplyUpgrade(upgradeScript):
	upgradeScript.Aplicar()

func Knockback(from_position):
	var direction = (global_position - from_position).normalized()
	var knockbackVelocity = direction * knockbackHorizontal
	knockbackVelocity.y = knockbackVertical
	velocity = knockbackVelocity
	knockbackTime = KNOCKBACK_DURATION
