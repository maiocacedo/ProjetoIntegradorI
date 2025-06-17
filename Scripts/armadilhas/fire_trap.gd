extends Node2D

@onready var animation = $AnimationPlayer
@onready var stateTimer = $Timer

var currentState := "fireOff" # para saber o status da trap

func _ready(): #inicia o status como off
	stateTimer.start()
	animation.play(currentState)

func _on_timer_timeout() -> void:
	 # Alterna entre os estados
	if currentState == "fireOn":
		currentState = "fireOff"
		stateTimer.start(4.0)  # tempo desligado
	else:
		currentState = "fireOn"
		stateTimer.start(1.0)  # tempo ligado
	animation.play(currentState)


func _on_fire_body_entered(body: Node2D) -> void: #quando o player enconstar reseta a fase
	if body.is_in_group("player"): # grupo que o player
		get_tree().reload_current_scene() # reset fase
