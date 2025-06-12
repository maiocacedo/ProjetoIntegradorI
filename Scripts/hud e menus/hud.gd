extends Control


@onready var timerCounter = $timer_counter as Label # texto do timer
@onready var temporizador = $temporizador as Timer # timer
@onready var menu_de_pausa = $menu_de_pausa # menu de pausa

signal times_is_up()

# Variáveis do timer
var pode_contar_tempo = true # Para verificar se o temporizador está ativo
var minutes = 0 # minutos
var seconds = 0 # segundos
@export var defaultMinutes := 0 # minutos padrão (definido por fase)
@export_range(0,59) var defaultSeconds := 30 # segundos  padrão (definido por fase)

func _ready() -> void:
	pode_contar_tempo = true
	reset_clock_timer() # Reseta o timer
	timerCounter.text = str("%02d" % defaultMinutes) + ":" +  str("%02d" % defaultSeconds) # Atualiza o texto



func _process(delta: float) -> void:
	# verifica se o timer chegou a zero
	if pode_contar_tempo and minutes == 0 and seconds == 0:
		emit_signal("times_is_up") # emite sinal de timer zerado
		reset_clock_timer() # reseta timer
		pode_contar_tempo = false # timer não está mais rodando

# Função para definir o comportamento do timer
func _on_temporizador_timeout() -> void:
	# Verifica se os segundos foram zerados
	if seconds == 0:
		minutes -= 1 # diminui um minuto
		seconds = 60 # define segundo para 60
	seconds -= 1 # decrementa segundos
	timerCounter.text = str("%02d" % minutes) + ":" +  str("%02d" % seconds) # atualiza texto

# reseta timer
func reset_clock_timer():
	minutes = defaultMinutes
	seconds = defaultSeconds

# Função para pausar o jogo
func _on_botao_pause_pressed() -> void:
	menu_de_pausa.visible = true
	get_tree().paused = true
