extends Control

@onready var timerCounter = $timer_counter as Label
@onready var temporizador = $temporizador as Timer
@onready var menu_de_pausa = $menu_de_pausa

var minutes = 0
var seconds = 0
@export var defaultMinutes := 0
@export_range(0,59) var defaultSeconds := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timerCounter.text = str("%02d" % defaultMinutes) + ":" +  str("%02d" % defaultSeconds)
	reset_clock_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_temporizador_timeout() -> void:
	if seconds == 59:
		minutes += 1
		seconds = -1
	seconds += 1
	timerCounter.text = str("%02d" % minutes) + ":" +  str("%02d" % seconds)

func reset_clock_timer():
	minutes = defaultMinutes
	seconds = defaultSeconds


func _on_botao_pause_pressed() -> void:
	menu_de_pausa.visible = true
	get_tree().paused = true
