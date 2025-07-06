extends Node2D

@export var levelName: String = "fase_9"
@export var pathProximaFase: String = "res://Cenas/Menu/tela_creditos.tscn"
@export var chavesNecessarias: int = 1
@export var alavancasNecessarias: int = 2
@export var minutosFase: float = 3.0
@export var segundosFase: float = 0.0

@onready var hud = $CanvasLayer/Hud
@onready var plataforma_logica = $Plataformas/plataforma6
@onready var alavancas = get_tree().get_nodes_in_group("alavanca")

var completed = false
var plataforma_liberada = false
var inventario_node = null
var chave_item = null
var erro_item_reportado: bool = false

func _ready() -> void:
	hud.set_tempo(minutosFase, segundosFase)
	plataforma_logica.visible = false

	inventario_node = get_tree().get_first_node_in_group("inventory")
	if inventario_node == null:
		print("ERRO: Nó de inventário não encontrado no grupo 'inventory'!")
	
	# Busca a chave (ID 1)
	if chave_item == null and not erro_item_reportado:
		if ItemDB.has_method("getItem"):
			chave_item = ItemDB.getItem(1)
			if chave_item == null:
				print("ERRO CRÍTICO NA FASE 9: O item com ID 1 não existe no ItemDB! A lógica da chave será desativada.")
				erro_item_reportado = true
		else:
			print("ERRO: ItemDB não possui o método 'getItem'.")
			erro_item_reportado = true

func atualizar_estado_plataforma() -> void:
	if plataforma_liberada or completed:
		return

	# --- Verifica alavancas ativadas ---
	var alavancas_ativadas = 0
	for alavanca in alavancas:
		if alavanca.ativada:
			alavancas_ativadas += 1
	var condicao_alavancas = alavancas_ativadas >= alavancasNecessarias

	# --- Verifica se há chave ---
	var condicao_chave = false
	if inventario_node != null and chave_item != null:
		if inventario_node.has_method("getQtdItem"):
			var qtd_chaves = inventario_node.getQtdItem(chave_item)
			condicao_chave = qtd_chaves >= chavesNecessarias

	# --- Libera plataforma se uma das condições for satisfeita ---
	if condicao_chave or condicao_alavancas:
		plataforma_logica.visible = true
		plataforma_liberada = true
		print("Plataforma liberada: condição satisfeita.")



func _on_portas_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or completed:
		return

	if not plataforma_logica.visible:
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
