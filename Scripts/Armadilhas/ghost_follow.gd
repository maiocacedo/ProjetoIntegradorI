extends CharacterBody2D

@export_group("Patrol Properties")
# Pontos de referência para o patrulhamento (A e B são os extremos, C define limite vertical)
@export var pointA: Marker2D # horizontal
@export var pointB: Marker2D # horizontal
@export var pointC: Marker2D # vertical
# Controle se o inimigo deve patrulhar e qual a velocidade
@export var usePatrol: bool = true
@export var patrolSpeed: float = 80.0

var patrolTarget: Marker2D

# Estados possíveis do inimigo
enum State { PATROLLING, CHASING, HIDING }
var state: State = State.PATROLLING

var player: CharacterBody2D
var direction: Vector2 = Vector2.ZERO
var patrolDirection: int = 1

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") # Pega o player como referência
	if usePatrol: # Se estiver patrulhando, define o ponto B como o primeiro alvo
		patrolTarget = pointB

# Verifica se o inimigo passou dos limites horizontais da patrulha
func hasPassedLimits() -> bool:
	var minX = min(pointA.global_position.x, pointB.global_position.x)
	var maxX = max(pointA.global_position.x, pointB.global_position.x)
	return global_position.x < minX or global_position.x > maxX

func _physics_process(delta: float) -> void:
	if not player:
		return
	match state:
		State.PATROLLING: # Se o jogador estiver na área e não estiver olhando para o inimigo
			patrol(delta)
			if isPlayerInsidePatrolArea() and not isPlayerLookingAtMe():
				state = State.CHASING
				$ReturnTimer.stop()

		State.CHASING: # Se passou dos limites, volta a patrulhar
			if hasPassedLimits():
				state = State.PATROLLING
				return
			
			if isPlayerLookingAtMe(): # Se o jogador estiver olhando, o inimigo para de se mover
				state = State.HIDING
				$ReturnTimer.start()
			else: 
				chasePlayer(delta)
				$ReturnTimer.stop()
		
		State.HIDING: # Se o jogador parar de olhar, volta a perseguir
			hideFace()
			if not isPlayerLookingAtMe():
				state = State.CHASING
				$ReturnTimer.stop()
			elif not $ReturnTimer.is_stopped(): # Se ainda está dentro do tempo de espera, permanece escondido
				pass

func patrol(delta): # Lógica de patrulha entre os pontos A e B
	if global_position.distance_to(patrolTarget.global_position) < 8.0: # Troca o alvo quando chega perto
		patrolTarget = pointA if patrolTarget == pointB else pointB
		
	# Move em direção ao alvo da patrulha
	var toTarget = patrolTarget.global_position - global_position
	var direction = toTarget.normalized()
	velocity = direction * patrolSpeed
	
	# Impede que o inimigo suba acima do ponto C (limite vertical)
	if (global_position.y + velocity.y * delta) < pointC.global_position.y:
		velocity.y = 0

	move_and_slide()
	
	# Animação e direção visual
	$anim.play("moving")
	if abs(velocity.x) > 0.1:
		patrolDirection = sign(velocity.x)
	$anim.flip_h = patrolDirection < 0

# Lógica de perseguição do jogador
func chasePlayer(delta):
	var toPlayer = (player.global_position - global_position).normalized()
	velocity = toPlayer * patrolSpeed
	
	# Impede subir acima do limite vertical (pointC)
	if (global_position.y + velocity.y * delta) < pointC.global_position.y:
		velocity.y = 0

	move_and_slide()
	
	# Atualiza animação e direção
	if abs(velocity.x) > 0.1:
		patrolDirection = sign(velocity.x)
		
	$anim.flip_h = patrolDirection < 0
	$anim.play("moving")

# Comportamento de "se esconder" (para e troca animação para se esconder)
func hideFace():
	velocity = Vector2.ZERO
	$anim.play("hide")

func isPlayerLookingAtMe() -> bool: # Verifica se o jogador está olhando diretamente para o inimigo
	var toEnemy = (global_position - player.global_position).normalized()
	var playerFacingDir = player.facingDir
	var dot = toEnemy.dot(playerFacingDir)
	return dot > 0.5 # Quanto mais próximo de 1, mais "de frente" está

# Chamado quando o temporizador esgota o tempo escondido
func _on_return_timer_timeout() -> void:
	state = State.PATROLLING

# Se o inimigo colidir com o jogador, reinicia a cena
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()

# Verifica se o jogador está dentro da área de patrulha (horizontal e vertical)
func isPlayerInsidePatrolArea() -> bool:
	var minX = min(pointA.global_position.x, pointB.global_position.x)
	var maxX = max(pointA.global_position.x, pointB.global_position.x)
	var minY = pointC.global_position.y

	var playerPos = player.global_position

	return (
		playerPos.x >= minX and playerPos.x <= maxX and
		playerPos.y >= minY  # Agora checa se está ABAIXO de pointC
	)
