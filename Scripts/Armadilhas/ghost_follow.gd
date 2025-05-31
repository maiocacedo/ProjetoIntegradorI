extends CharacterBody2D

@export_group("Patrol Propeties")
@export var point_a: Marker2D
@export var point_b: Marker2D
@export var use_patrol: bool = true
@export var patrol_speed: float = 80.0

var patrol_target: Marker2D
enum State { PATROLLING, CHASING, HIDING } # status do fantasma
var state: State = State.PATROLLING # inicia patrulhando

var player: CharacterBody2D # Quem ele tem que seguir
var direction: Vector2 = Vector2.ZERO
var patrol_direction: int = 1 # direção

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") # se o player foi atribuido
	if use_patrol: # se a booleana estiver ativado
		patrol_target = point_b

func has_passed_limits() -> bool:
	# Considerando apenas o eixo X, ajuste se também usar Y
	var min_x = min(point_a.global_position.x, point_b.global_position.x)
	var max_x = max(point_a.global_position.x, point_b.global_position.x)
	return global_position.x < min_x or global_position.x > max_x

func _physics_process(delta: float) -> void:
	if not player:
		return
	match state:
		State.PATROLLING:
			patrol(delta)
			if not is_player_looking_at_me():
				state = State.CHASING
				$ReturnTimer.stop()

		State.CHASING:
			# Verifica se passou do point_a ou point_b
			if has_passed_limits():
				state = State.PATROLLING
				return
			
			if is_player_looking_at_me():
				state = State.HIDING
				$ReturnTimer.start()
			else:
				chase_player(delta)
				$ReturnTimer.stop()
		
		State.HIDING:
			hide_face()
			if not is_player_looking_at_me():
				state = State.CHASING
				$ReturnTimer.stop()
			elif not $ReturnTimer.is_stopped():
				pass

func patrol(delta):
	if global_position.distance_to(patrol_target.global_position) < 8.0:
		if patrol_target == point_b:
			patrol_target = point_a
		else:
			patrol_target = point_b
	
	var to_target = patrol_target.global_position - global_position
	var direction = to_target.normalized()
	velocity = direction * patrol_speed
	move_and_slide()
	
	$anim.play("moving")
	if abs(velocity.x) >  0.1:
		patrol_direction = sign(velocity.x)
		
	$anim.flip_h = patrol_direction < 0

func chase_player(delta):
	var to_player = (player.global_position - global_position).normalized()
	velocity = to_player * patrol_speed
	move_and_slide()
	
	if abs(velocity.x) > 0.1:
		patrol_direction - sign(velocity.x)
		
	$anim.flip_h = patrol_direction < 0
	$anim.play("moving")
	
func hide_face():
	velocity = Vector2.ZERO
	$anim.play("hide")
	
func is_player_looking_at_me() -> bool:
	var to_enemy = (global_position - player.global_position).normalized()
	var player_facing_dir = player.facing_dir
	var dot = to_enemy.dot(player_facing_dir)
	return dot > 0.5
	


func _on_return_timer_timeout() -> void:
	state = State.PATROLLING


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
