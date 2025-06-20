extends CanvasLayer

@onready var tempo_counter = $fundo_solido2/tempo_counter  # timer
@onready var estrela_1 = $fundo_solido2/estrelas_1/estrela_1 # estrela 1
@onready var estrela_2 = $fundo_solido2/estrelas_1/estrela_2 # estrela 2 
@onready var estrela_3 = $fundo_solido2/estrelas_1/estrela_3 # estrela 3

var estrelaPath = "res://Assets/sprites/estrela.png" # caminho da estrela "acesa"
var estrelaText : Texture2D = load(estrelaPath) # carregando estrela como textura

# Path da proxima fase
var proximaFase: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false # inicia invisivel 
	process_mode = Node.PROCESS_MODE_ALWAYS # Permite rodar com as cenas pausadas

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_proxima_fase_pressed() -> void:
	visible = false # Torna invisivel novamente
	get_tree().paused = false # Despausa cena
	get_tree().change_scene_to_file(proximaFase) 

func _on_loja_pressed() -> void:
	visible = false # Torna invisivel novamente
	get_tree().paused = false # Despausa cena
	get_tree().change_scene_to_file("res://Cenas/hud e menus/Store.tscn") # mudar para loja

func _on_voltar_ao_menu_pressed() -> void:
	visible = false # Torna invisivel novamente
	get_tree().paused = false # Despausa cena
	get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn") # retorna a menu
	
# Função que exibe resultados
func resultados(tempoDecorrido:float, estrelas: int, proxFase: String):
	# Passa a path da proxima fase
	proximaFase = proxFase
	# condicional para "acender" as estrelas de acordo com o desempenho
	if estrelas == 1:
		estrela_1.texture = estrelaText
	elif (estrelas == 2):
		estrela_1.texture = estrelaText
		estrela_2.texture = estrelaText
	else: 
		estrela_1.texture = estrelaText
		estrela_2.texture = estrelaText
		estrela_3.texture = estrelaText
	
	# convertendo tempo para minutos e segundos
	var levelMinutes = int(tempoDecorrido) / 60
	var levelSeconds = int(tempoDecorrido) % 60
	
	# Alterando texto do tempo
	tempo_counter.text = str("%02d" % levelMinutes) + ":" +  str("%02d" % levelSeconds)
	get_tree().paused = true # pausa as cenas
		
