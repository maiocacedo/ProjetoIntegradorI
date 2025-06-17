extends CharacterBody2D

@export var inv: Inv

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speedUpgradeScript := preload("res://Assets/Scripts/SpeedUpgrade.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://Assets/Scripts/DamageUpgrade.gd").new()
var jumpUpgradeScript := preload("res://Assets/Scripts/JumpUpgrade.gd").new()

var knockbackHorizontal = 800 #define a força horizontal do knockback
var knockbackVertical = -300 #define a força vertical do knockback

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = PlayerData.stats["jumpSpeed"]
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
		velocity.x = direction * PlayerData.stats["speed"]
	else:
		velocity.x = move_toward(velocity.x, 0, PlayerData.stats["speed"])

	if Input.is_action_just_pressed("F1"): #aplica o upgrade de velocidade
		PlayerData.hasSpeedUpgrade = !PlayerData.hasSpeedUpgrade #muda para true que tem o upgrade
	
		
	ApplyUpgrade(speedUpgradeScript) #aplica o buff de velocidade
	
	if Input.is_action_just_pressed("F2"): #upgrade dialogo
		PlayerData.hasDamageUpgrade = !PlayerData.hasDamageUpgrade
		
	if Input.is_action_just_pressed("F4"):
		PlayerData.hasJumpUpgrade = !PlayerData.hasJumpUpgrade #ativa o buff
		
	ApplyUpgrade(jumpUpgradeScript) #aplica o buff
	
	if Input.is_action_just_pressed("F5"):
		PlayerData.hasPergaminho = !PlayerData.hasPergaminho
		
	

	move_and_slide()

func collect(item):
	inv.insert(item)
	
	
func ApplyUpgrade(upgradeScript): #método para ser utilizado no molde
	upgradeScript.Aplicar() #chama o método da outra classe

func Knockback(from_position):
	var direction = (global_position - from_position).normalized() #define a direção do knockback
	var knockbackVelocity = direction * knockbackHorizontal #a velocidade
	knockbackVelocity.y = knockbackVertical #a velocidade do eixo y
	move_and_slide()
	velocity = knockbackVelocity
