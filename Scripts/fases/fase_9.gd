extends Node2D

@export var levelName: String
@export var pathProximaFase: String
@export var chavesNecessarias: int 
@export var alavancasNecessarias: int
@export var minutosFase: float
@export var segundosFase: float

@onready var hud = $CanvasLayer/Hud
@onready var plataforma_logica = $Plataformas/plataforma6
@onready var alavancas = get_tree().get_nodes_in_group("alavanca")

var completed = false
var inventario_node = null
var chave_item = null
var erro_item_reportado: bool = false  # NOVO: controle para evitar spam de erro

func _ready() -> void:
	hud.set_tempo(minutosFase, segundosFase)
	plataforma_logica.visible = false

	inventario_node = get_tree().get_first_node_in_group("inventory")
	if inventario_node == null:
		print("ERRO: Nó de inventário não encontrado no grupo 'inventory'!")

	# Tenta buscar o item apenas uma vez e evita print repetido
	if chave_item == null and not erro_item_reportado:
		if ItemDB.has_method("getItem"):
			chave_item = ItemDB.getItem(1)
			if chave_item == null:
				print("ERRO CRÍTICO NA FASE 9: O item com ID 1 não existe no ItemDB! A lógica da chave será desativada.")
				erro_item_reportado = true
		else:
			print("ERRO: ItemDB não possui o método 'getItem'.")
			erro_item_reportado = true

func _process(delta: float) -> void:
	if completed:
		return

	verificar_logica_plataforma()

func verificar_logica_plataforma() -> void:
	if inventario_node == null or chave_item == null:
		return

	# --- Condição 1: Verifica alavancas ativadas ---
	var alavancas_ativadas = 0
	for alavanca in alavancas:
		if "ativada" in alavanca:
			if alavanca.ativada:
				alavancas_ativadas += 1
		else:
			print("AVISO: Alavanca sem variável 'ativada'!")

	var condicao_alavancas = (alavancas_ativadas >= alavancasNecessarias)

	# --- Condição 2: Verifica chaves no inventário ---
	var qtdChaves = 0
	if inventario_node.has_method("getQtdItem"):
		qtdChaves = inventario_node.getQtdItem(chave_item)
	else:
		print("Inventário não possui o método 'getQtdItem'!")

	var condicao_chave = (qtdChaves >= chavesNecessarias)

	plataforma_logica.visible = condicao_alavancas or condicao_chave

func _on_Porta_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or completed:
		return

	if not plataforma_logica.visible:
		hud.show_message("O caminho parece incompleto...")
		return

	completed = true

	var tempoDecorrido = hud.get_tempo_decorrido()
	hud.visible = false

	SaveManager.update_level_progress(levelName, tempoDecorrido)

	var estrelas = 1
	if tempoDecorrido <= SaveManager.recompensaLevels[levelName]["3"]:
		estrelas = 3
	elif tempoDecorrido <= SaveManager.recompensaLevels[levelName]["2"]:
		estrelas = 2

	hud.mostra_resultado(tempoDecorrido, estrelas, pathProximaFase)
	print("Fase final concluída com ", estrelas, " estrela(s). Tempo: ", tempoDecorrido)
