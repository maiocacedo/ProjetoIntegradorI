extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@export var inv: Inv

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var facing_dir := Vector2.RIGHT # DO GHOST
func _physics_process(delta: float) -> void:
	# DO GHOST
	if abs(velocity.x) > 0.1:
		facing_dir = Vector2.RIGHT if velocity.x > 0 else Vector2.LEFT
	
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
	
	for platforms in get_slide_collision_count(): # Plataforma que cai
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
	
func collect(item):
	inv.insert(item)
