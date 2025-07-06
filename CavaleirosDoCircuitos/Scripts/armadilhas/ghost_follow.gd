extends CharacterBody2D

@export_group("Patrol Properties")
# Pontos de referência para o patrulhamento (A e B são os extremos, C define limite vertical)
@export var pointA: Marker2D # horizontal
@export var pointB: Marker2D # horizontal
@export var pointC: Marker2D # vertical
@export var pointD: Marker2D # Limite inferior vertical

@onready var timer: Timer = $Timer
@onready var morte: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Controle se o inimigo deve patrulhar e qual a velocidade
@export var usePatrol: bool = true
@export var patrolSpeed: float = 80.0

var patrolTarget: Marker2D

# Estados possíveis do inimigo
enum State { PATROLLING, CHASING, HIDING, STUN }
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
		State.PATROLLING:
			patrol(delta)
			if isPlayerInsidePatrolArea() and not isPlayerLookingAtMe():
				state = State.CHASING
				$ReturnTimer.stop()

		State.CHASING:
			if not isPlayerInsidePatrolArea(): # <--- jogador saiu da área?
				state = State.PATROLLING
				return

			if hasPassedLimits():
				state = State.PATROLLING
				return

			if isPlayerLookingAtMe():
				state = State.HIDING
				$ReturnTimer.start()
			else:
				chasePlayer(delta)
				$ReturnTimer.stop()

		State.HIDING:
			hideFace()
			if not isPlayerInsidePatrolArea(): # <--- jogador saiu da área?
				state = State.PATROLLING
				$ReturnTimer.stop()
			elif not isPlayerLookingAtMe():
				state = State.CHASING
				$ReturnTimer.stop()
			elif not $ReturnTimer.is_stopped():
				pass
				
		State.STUN:
			velocity = Vector2.ZERO
			$anim.play("hide")
			await get_tree().create_timer(3).timeout
			state = State.PATROLLING
			
func patrol(delta):
	var toTarget = patrolTarget.global_position - global_position
	var distance = toTarget.length()

	# Quando estiver suficientemente perto do ponto de destino, troca o alvo
	if distance < 4.0:  # pode ajustar esse valor se quiser
		if patrolTarget == pointA:
			patrolTarget = pointB
		else:
			patrolTarget = pointA

	# Atualiza direção e velocidade
	var direction = toTarget.normalized()
	velocity = direction * patrolSpeed

	# Impede que o inimigo suba acima do ponto C ou abaixo do D (limites verticais)
	var futureY = global_position.y + velocity.y * delta
	if futureY < pointC.global_position.y or futureY > pointD.global_position.y:
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
	var futureY = global_position.y + velocity.y * delta
	if futureY < pointC.global_position.y or futureY > pointD.global_position.y:
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
	if body.is_in_group("player"): #verifica o grupo
		if PlayerData.hasPergaminho and PlayerData.hasDamageUpgrade:
			if PlayerData.damageUpgradeApplied:
				ActivateProtection()
				body.Knockback(global_position) #chama a função
				
				return
			else:
				ActivateDamageUpgrade()
				return
		elif PlayerData.hasDamageUpgrade and not PlayerData.damageUpgradeApplied:
			ActivateDamageUpgrade()
			return
		elif PlayerData.hasPergaminho and not PlayerData.pergaminhoUsado:
			ActivateProtection()
			body.Knockback(global_position) #chama a função
			return
		else:
			body.die()
			morte.playing = true 
			timer.start()
			PlayerData.damageUpgradeApplied = false
			PlayerData.pergaminhoUsado = false
			
func ActivateDamageUpgrade() -> void:
		if PlayerData.hasDamageUpgrade and not PlayerData.damageUpgradeApplied:
			PlayerData.damageUpgradeApplied = true
			var inventory = get_tree().get_first_node_in_group("inventory")
			inventory.removerItem(ItemDB.getItem(5), null)
			queue_free()
			
func ActivateProtection() -> void:
	if PlayerData.hasPergaminho and not PlayerData.pergaminhoUsado:
		PlayerData.pergaminhoUsado = true
		state = State.STUN
		var inventory = get_tree().get_first_node_in_group("inventory")
		inventory.removerItem(ItemDB.getItem(4), null)
		
# Verifica se o jogador está dentro da área de patrulha (horizontal e vertical)
func isPlayerInsidePatrolArea() -> bool:
	var minX = min(pointA.global_position.x, pointB.global_position.x)
	var maxX = max(pointA.global_position.x, pointB.global_position.x)
	var minY = pointC.global_position.y
	var maxY = pointD.global_position.y

	var playerPos = player.global_position

	return (
	playerPos.x >= minX and playerPos.x <= maxX and
	playerPos.y >= minY and playerPos.y <= maxY
)


func _on_timer_timeout() -> void:
	GameManager.call_deferred("abrir_tela_de_morte","Morte Morrida")
