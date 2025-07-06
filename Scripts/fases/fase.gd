extends Node2D

#XOR

# Referência à HUD
@onready var hud = $CanvasLayer/Hud

# Dados exportáveis para configurar a fase no editor
@export var levelName: String               # Nome do nível (ex: "fase_1")
@export var msgPorta: String                # Mensagem ao tentar passar pela porta sem os requisitos
@export var chavesNecessarias: int          # Número de chaves exigidas
@export var alavancasNecessarias: int       # Número de alavancas a serem ativadas
@export var pathProximaFase: String         # Path da Próxima fase
@export var minutosFase: float              # Minutos totais para fazer a fase
@export var segundosFase: float             # Segundos Totais para fazer a fase

# Controle de conclusão da fase
var completed = false

# Chamado ao iniciar a cena
func _ready() -> void:
	hud.set_tempo(minutosFase, segundosFase)
	pass  # Por enquanto nada aqui

# Chamado a cada frame
func _process(delta: float) -> void:
	pass  # Por enquanto nada aqui

# Quando o corpo entra em uma porta
func _on_porta_body_entered(body: Node2D) -> void:
	# Ignora se não for o jogador
	if not body.is_in_group("player"):
		return

	# Evita processar se a fase já foi concluída
	if completed:
		return

	# Busca o inventário no grupo "inventory"
	var inventory_node = get_tree().get_first_node_in_group("inventory")
	if inventory_node == null:
		print("Inventário não encontrado.")
		return

	# Verifica a quantidade de chaves (ID do item 1)
	var chave = ItemDB.getItem(1)
	var qtdChaves = inventory_node.getQtdItem(chave)

	if qtdChaves != chavesNecessarias:
		$Porta/Label.text = msgPorta
		print("Você precisa de %d chaves para passar de fase." % chavesNecessarias)
		return

	# Verifica se a quantidade necessária de alavancas foi ativada
	var alavancas = get_tree().get_nodes_in_group("alavanca")
	var alavancas_ativadas = 0

	for alavanca in alavancas:
		if alavanca.ativada:
			alavancas_ativadas += 1

	if alavancas_ativadas != alavancasNecessarias:
		$Porta/Label.text = msgPorta
		print("Você precisa ativar %d alavancas." % alavancasNecessarias)
		return

	# Se tudo estiver OK, marca como concluído
	completed = true

	# Obtém o tempo decorrido
	var tempoDecorrido = hud.get_tempo_decorrido()
	hud.visible = false

	# Atualiza progresso no SaveManager
	SaveManager.update_level_progress(levelName, tempoDecorrido)

	# Calcula estrelas baseadas no tempo
	var estrelas = 1
	if tempoDecorrido <= SaveManager.recompensaLevels[levelName]["3"]:
		estrelas = 3
	elif tempoDecorrido <= SaveManager.recompensaLevels[levelName]["2"]:
		estrelas = 2

	# Mostra resultado e troca de cena
	hud.mostra_resultado(tempoDecorrido, estrelas, pathProximaFase)

# Quando o corpo sai da porta, limpa a mensagem
func _on_porta_body_exited(body: Node2D) -> void:
	$Porta/Label.text = ""
