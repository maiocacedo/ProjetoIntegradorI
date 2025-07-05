extends "res://Scripts/armadilhas/Armadilhas.gd"

@onready var animation = $AnimationPlayer
@onready var stateTimer = $Timer
@onready var timer = $Timer2
@onready var morte = $AudioStreamPlayer2D

var currentState := "fireOff" # para saber o status da trap

func _ready(): #inicia o status como off
	stateTimer.start()
	animation.play(currentState)

func _on_timer_timeout() -> void:
	 # Alterna entre os estados
	if currentState == "fireOn":
		currentState = "fireOff"
		stateTimer.start(2.0)  # tempo desligado
	else:
		currentState = "fireOn"
		stateTimer.start(1.0)  # tempo ligado
	animation.play(currentState)


func _on_fire_body_entered(body: Node2D) -> void: #quando o player enconstar reseta a fase
	Verificacao(body, morte, timer)

func _on_timer_2_timeout() -> void:
	GameManager.call_deferred("abrir_tela_de_morte","Brincou com fogo!")
