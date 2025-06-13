extends Node2D

@onready var animation = $AnimationPlayer
@onready var stateTimer = $Timer

var currentState := "fireOff"

func _ready():
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


func _on_fire_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
