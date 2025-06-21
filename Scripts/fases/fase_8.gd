extends Node2D

@onready var hud = $CanvasLayer/Hud

var levelName = "fase_8"
var completed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Função para finalizar fase


func _on_portas_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	if completed:
		return
	
	# Verifica chave
	var inventory_node = get_tree().get_first_node_in_group("inventory")
	if inventory_node == null:
		print("Inventário não encontrado.")
		return
	
	var chave = ItemDB.getItem(1)
	var qtd_chaves = inventory_node.getQtdItem(chave)
	
	if qtd_chaves < 3:
		print("Você precisa da chave!")
		return
	
	# Verifica se duas alavancas foram ativadas
	var alavancas = get_tree().get_nodes_in_group("alavanca")
	var alavancas_ativadas = 0

	for alavanca in alavancas:
		if alavanca.ativada:
			alavancas_ativadas += 1

	if alavancas_ativadas < 2:
		print("Você precisa ativar as duas alavancas!")
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
	
	hud.mostra_resultado(tempoDecorrido, estrelas)
