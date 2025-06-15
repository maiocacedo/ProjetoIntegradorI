extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var hasRefrigerante: bool # Adicionado para testar
@export var hasTenis: bool # Adicionado para testar
@export var hasEscudo: bool # Adicionado para testar
@export var hasEscudoEspinhos: bool # Adicionado para testar

# Lembrar de adicionar no pesonagem, para que o inv funcione
func _ready():
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY
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
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
