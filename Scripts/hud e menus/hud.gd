extends Control

# Referências aos nós da cena
@onready var timerCounter: Label = $timer_counter        # Texto do timer (Label)
@onready var temporizador: Timer = $temporizador         # Timer que aciona decremento a cada segundo
@onready var menu_de_pausa = $menu_de_pausa              # Menu de pausa
@onready var menu_de_congratulacoes = $menu_de_congratulacoes  # Menu de resultados

# Sinal emitido quando o tempo acaba
signal times_is_up()

# Variáveis do tempo
var podeContarTempo := true           # Se o temporizador está ativo
var minutes: int = 0                  # Minutos restantes
var seconds: int = 0                  # Segundos restantes

# Tempo padrão por fase (definível no editor)
@export var defaultMinutes := 0
@export_range(0, 59) var defaultSeconds := 45.0

# ---------------------------------------
# Inicialização
# ---------------------------------------
func _ready() -> void:
	podeContarTempo = true
	reset_clock_timer()
	atualizar_texto_timer()
	temporizador.start()  # Inicia o temporizador

# ---------------------------------------
# Timer de 1 segundo expirou
# ---------------------------------------
func _on_temporizador_timeout() -> void:
	if not podeContarTempo:
		return

	print(str(seconds) + " " + str(minutes))

	if minutes == 0 and seconds == 0:
		print("a")
		podeContarTempo = false
		GameManager.call_deferred("abrir_tela_de_morte", "Tempo esgotado")
		temporizador.stop()
		return

	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59
	else:
		seconds -= 1

	atualizar_texto_timer()

# ---------------------------------------
# Atualiza o texto do cronômetro na tela
# ---------------------------------------
func atualizar_texto_timer() -> void:
	timerCounter.text = "%02d:%02d" % [minutes, seconds]

# ---------------------------------------
# Reseta o timer com os valores padrão
# ---------------------------------------
func reset_clock_timer() -> void:
	minutes = defaultMinutes
	seconds = int(defaultSeconds)  # Evita float no contador

# ---------------------------------------
# Define o tempo do cronômetro manualmente
# ---------------------------------------
func set_tempo(min: int, sec: int) -> void:
	minutes = min
	seconds = clamp(sec, 0, 59)
	defaultMinutes = min
	defaultSeconds = sec
	atualizar_texto_timer()

# ---------------------------------------
# Retorna o tempo decorrido em segundos
# ---------------------------------------
func get_tempo_decorrido() -> float:
	var total_inicial = defaultMinutes * 60 + int(defaultSeconds)
	var restante = minutes * 60 + seconds
	return total_inicial - restante

# ---------------------------------------
# Exibe o menu de resultados
# ---------------------------------------
func mostra_resultado(tempoDecorrido: float, estrelas: int, proxFase: String) -> void:
	podeContarTempo = false  # Impede que o timeout continue contando
	temporizador.stop()      # Para o Timer ativo
	menu_de_congratulacoes.visible = true
	MusicManager._play_music("res://Assets/music/musica_vitoria.wav")
	menu_de_congratulacoes.resultados(tempoDecorrido, estrelas, proxFase)

# ---------------------------------------
# Botão de pausa pressionado
# ---------------------------------------
func _on_botao_pause_pressed() -> void:
	if not menu_de_congratulacoes.visible:
		menu_de_pausa.visible = true
		get_tree().paused = true

# ---------------------------------------
# Botões da Movimentação
# ---------------------------------------

func _on_esquerda_pressed() -> void:
	Input.action_press("esquerda")


func _on_direita_pressed() -> void:
	Input.action_press("direita")


func _on_pulo_pressed() -> void:
	Input.action_press("pular")


func _on_esquerda_released() -> void:
	Input.action_release("esquerda")


func _on_direita_released() -> void:
	Input.action_release("direita")


func _on_pulo_released() -> void:
	Input.action_release("pular")
