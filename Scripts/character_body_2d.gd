extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var alive = true


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speedUpgradeScript := preload("res://Scripts/upgrades/SpeedUpgrade.gd").new() #referencia ao outro arquivo, como se fosse o get component
var damageUpgradeScript := preload("res://Scripts/upgrades/DamageUpgrade.gd").new()
var jumpUpgradeScript := preload("res://Scripts/upgrades/JumpUpgrade.gd").new()

var knockbackHorizontal = 800 #define a força horizontal do knockback
var knockbackVertical = -300 #define a força vertical do knockback

var jumpsLeft = 2

var facingDir := Vector2.RIGHT # A Direção inicial do personagem está "olhando" (para a direita
func _physics_process(delta: float) -> void:
	if not alive:
		animated_sprite_2d.play("parado")
		return
	
	# DO GHOST
	if abs(velocity.x) > 0.1:# Atualiza a direção do player com base na velocidade horizontal
		# Se a velocidade X for positiva, o player olha para a direita; se negativa, para a esquerda
		facingDir = Vector2.RIGHT if velocity.x > 0 else Vector2.LEFT
	
	
	# Aplica gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumpsLeft = 2  # reseta os pulos ao tocar o chão

	# Pulo (inclusive duplo)
	if Input.is_action_just_pressed("pular") and jumpsLeft > 0:
		velocity.y = JUMP_VELOCITY
		jump.playing = true
		jumpsLeft -= 1

	# Movimento horizontal
	var direction := Input.get_axis("esquerda", "direita")

	# Animações
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("parado")
		else:
			animated_sprite_2d.play("corre")
	else:
		animated_sprite_2d.play("pula")

	# Espelhamento do sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Movimento
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#plataforma que cai
	# Para cada colisão detectada durante o movimento do player
	for platforms in get_slide_collision_count(): 
		var collision = get_slide_collision(platforms)  #Obtém o objeto da colisão na posição i
		if collision.get_collider().has_method("has_collided_with"): # Verifica se o objeto(plataforma) colidido possui o método 'has_collided_with'
			collision.get_collider().has_collided_with(collision, self) # Chama o método 'has_collided_with' da plataforma, passando a colisão e o player
	

func die() -> void:
	alive = false

func collect(item):
	pass

func ApplyUpgrade(upgradeScript): #método para ser utilizado no molde
	upgradeScript.Aplicar() #chama o método da outra classe

func Knockback(from_position):
	var direction = (global_position - from_position).normalized() #define a direção do knockback
	var knockbackVelocity = direction * knockbackHorizontal #a velocidade
	knockbackVelocity.y = knockbackVertical #a velocidade do eixo y
	move_and_slide()
	velocity = knockbackVelocity
