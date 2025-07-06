extends AnimatableBody2D

@onready var anim := $anim as AnimationPlayer
@onready var respawn := $respawn as Timer
@onready var respawnPosition := global_position # para voltar a posição

@export var resetTimer := 3.0 # o tempo para ela voltar

var velocity = Vector2.ZERO
var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity") # Valor da gravidade padrão definido no projeto
var isTriggered := false # Controla se a armadilha já foi ativada para evitar múltiplas ativações


func _ready() -> void:
	# Desativa o processamento contínuo (process) até a animação terminar
	set_process(false)


func _process(delta: float) -> void:
	# Aplica a gravidade acumulada à velocidade vertical
	velocity.y += gravidade * delta
	position += velocity * delta # Move a armadilha com base na velocidade atual

# Função chamada quando ocorre uma colisão com outro corpo (player)
func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !isTriggered:
		isTriggered = true
		anim.play("quake") # Toca a animação de "tremor"
		velocity = Vector2.ZERO # Reseta a velocidade
		


func _on_anim_animation_finished(anim_name: StringName) -> void:
	set_process(true) # Ativa o process para começar a queda
	respawn.start(resetTimer) # Inicia o timer para o respawn


func _on_respawn_timeout() -> void:
	set_process(false)
	global_position = respawnPosition # Volta à posição inicial
	
	$texture.visible = true
	$texture.modulate.a = 0.0  # Começa invisível
	var spawnTween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	spawnTween.tween_property($texture, "modulate:a", 1.0, 0.2) # vota a textura

	isTriggered = false # Permite que a armadilha possa ser ativada novamente
