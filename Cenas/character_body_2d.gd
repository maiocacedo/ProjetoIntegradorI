extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@export var inv: Inv

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var jumps_left = 2  # número de pulos restantes

func _physics_process(delta: float) -> void:
	# Aplica gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_left = 2  # reseta os pulos ao tocar o chão

	# Pulo (inclusive duplo)
	if Input.is_action_just_pressed("pular") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		audio_stream_player_2d.playing = true
		jumps_left -= 1

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

func collect(item):
	inv.insert(item)
