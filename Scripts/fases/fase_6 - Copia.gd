extends Node2D

#OR
@onready var hud = $CanvasLayer/Hud

@export var pathProximaFase: String 

var levelName = "fase_6"
var completed = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

# Quando o jogador encosta na porta
func _on_portas_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	if completed:
		return
	
	# Verifica se pegou a chave (ID 1)
	var tem_chave := false
	var inventory_node = get_tree().get_first_node_in_group("inventory")
	if inventory_node:
		var chave = ItemDB.getItem(1)
		var qtd_chaves = inventory_node.getQtdItem(chave)
		tem_chave = qtd_chaves >= 1
		print("Qtd de chaves:", qtd_chaves)
	else:
		print("Inventário não encontrado!")

	# Verifica se a alavanca foi ativada
	var alavanca_ativada := false
	var alavanca_node = get_tree().get_first_node_in_group("alavanca")
	if alavanca_node:
		alavanca_ativada = alavanca_node.ativada
		print("Alavanca ativada:", alavanca_ativada)
	else:
		print("Alavanca não encontrada!")

	# Porta lógica OR: pode passar se tiver a chave ou a alavanca ativada
	if tem_chave or alavanca_ativada:
		# Pode passar
		pass
	else:
		print("Você precisa da chave ou ativar a alavanca!")
		if hud.has_method("show_message"):
			hud.show_message("Você precisa da chave ou ativar a alavanca!")
		return

	
	# Se passou, finaliza a fase
	completed = true
	var tempoDecorrido = hud.get_tempo_decorrido()
	hud.visible = false
	SaveManager.update_level_progress(levelName, tempoDecorrido)

	# Cálculo das estrelas
	var estrelas = 1
	if tempoDecorrido <= SaveManager.recompensaLevels[levelName]["3"]:
		estrelas = 3
	elif tempoDecorrido <= SaveManager.recompensaLevels[levelName]["2"]:
		estrelas = 2

	hud.mostra_resultado(tempoDecorrido, estrelas, pathProximaFase)
	print("Fase concluída com", estrelas, "estrela(s). Tempo:", tempoDecorrido)
