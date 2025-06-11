extends CharacterBody2D

@export_group("Patrol Properties")
@export var pointA: Marker2D
@export var pointB: Marker2D
@export var pointC: Marker2D

@export var usePatrol: bool = true
@export var patrolSpeed: float = 80.0

var patrolTarget: Marker2D
enum State { PATROLLING, CHASING, HIDING }
var state: State = State.PATROLLING

var player: CharacterBody2D
var direction: Vector2 = Vector2.ZERO
var patrolDirection: int = 1

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if usePatrol:
		patrolTarget = pointB

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
			if not isPlayerLookingAtMe():
				state = State.CHASING
				$ReturnTimer.stop()
			elif not $ReturnTimer.is_stopped():
				pass

func patrol(delta):
	if global_position.distance_to(patrolTarget.global_position) < 8.0:
		patrolTarget = pointA if patrolTarget == pointB else pointB
	
	var toTarget = patrolTarget.global_position - global_position
	var direction = toTarget.normalized()
	velocity = direction * patrolSpeed

	if (global_position.y + velocity.y * delta) < pointC.global_position.y:
		velocity.y = 0

	move_and_slide()

	$anim.play("moving")
	if abs(velocity.x) > 0.1:
		patrolDirection = sign(velocity.x)
	$anim.flip_h = patrolDirection < 0

func chasePlayer(delta):
	var toPlayer = (player.global_position - global_position).normalized()
	velocity = toPlayer * patrolSpeed

	if (global_position.y + velocity.y * delta) < pointC.global_position.y:
		velocity.y = 0

	move_and_slide()
	
	if abs(velocity.x) > 0.1:
		patrolDirection = sign(velocity.x)
		
	$anim.flip_h = patrolDirection < 0
	$anim.play("moving")

func hideFace():
	velocity = Vector2.ZERO
	$anim.play("hide")

func isPlayerLookingAtMe() -> bool:
	var toEnemy = (global_position - player.global_position).normalized()
	var playerFacingDir = player.facingDir
	var dot = toEnemy.dot(playerFacingDir)
	return dot > 0.5

func _on_return_timer_timeout() -> void:
	state = State.PATROLLING

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()

func isPlayerInsidePatrolArea() -> bool:
	var minX = min(pointA.global_position.x, pointB.global_position.x)
	var maxX = max(pointA.global_position.x, pointB.global_position.x)
	var minY = pointC.global_position.y

	var playerPos = player.global_position

	return (
		playerPos.x >= minX and playerPos.x <= maxX and
		playerPos.y >= minY  # Agora checa se está ABAIXO de pointC
	)
