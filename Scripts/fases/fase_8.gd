extends Node2D

# Referência à HUD
@onready var hud = $CanvasLayer/Hud

# Dados exportáveis para configurar a fase no editor
@export var levelName: String               # Nome do nível (ex: "fase_1")
@export var msgPorta: String                # Mensagem ao tentar passar pela porta sem os requisitos
@export var chavesNecessarias: int          # Número de chaves exigidas
@export var alavancasNecessarias: int       # Número de alavancas a serem ativadas
@export var pathProximaFase: String         # Path da Próxima fase
@export var minutosFase: float
@export var segundosFase: float

# Controle de conclusão da fase
var completed = false

# Chamado ao iniciar a cena
func _ready() -> void:
	hud.set_tempo(minutosFase, segundosFase)
	pass

# Chamado a cada frame
func _process(delta: float) -> void:
	pass  # Por enquanto nada aqui

# Quando o corpo sai da porta, limpa a mensagem
func _on_porta_body_exited(body: Node2D) -> void:
	$Porta/Label.text = ""
	
func _on_porta_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	if completed:
		return
	
	# Conta as chaves obtidas
	var inventory_node = get_tree().get_first_node_in_group("inventory")
	if inventory_node == null:
		print("Inventário não encontrado.")
		return
	
	var chave = ItemDB.getItem(1)
	var qtd_chaves = inventory_node.getQtdItem(chave)

	# Conta alavancas ativadas
	var alavancas = get_tree().get_nodes_in_group("alavanca")
	var alavancas_ativadas = 0
	
	for alavanca in alavancas:
		if alavanca.ativada:
			alavancas_ativadas += 1

	if (alavancas_ativadas == 0 && qtd_chaves >= 1):
		$Porta/Label.text = msgPorta
		return
	if (alavancas_ativadas == 1 && qtd_chaves == 0):
		$Porta/Label.text = msgPorta
		return

	# Marca como concluída
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
