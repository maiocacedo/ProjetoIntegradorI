extends AnimatableBody2D

@onready var anim := $anim as AnimationPlayer
@onready var respawn := $respawn as Timer
@onready var respawn_position := global_position

@export var reset_timer := 3.0

var velocity = Vector2.ZERO
var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravidade * delta
	position += velocity * delta

func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("quake")
		velocity = Vector2.ZERO
		


func _on_anim_animation_finished(anim_name: StringName) -> void:
	set_process(true)
	respawn.start(reset_timer)


func _on_respawn_timeout() -> void:
	set_process(false)
	global_position = respawn_position
	
	$texture.visible = true
	$texture.modulate.a = 0.0  # Garante que a opacidade comece em 0
	var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	spawn_tween.tween_property($texture, "modulate:a", 1.0, 0.2)

	is_triggered = false
