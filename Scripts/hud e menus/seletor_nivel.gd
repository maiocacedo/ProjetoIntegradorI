extends Control

@onready var estrelas_label = $estrelas_label # Numero de estrelas adquiridas

var estrelaPath = "res://Assets/sprites/estrela.png" # Caminho da estrela
var estrelaText : Texture2D = load(estrelaPath) # Carregando estrela como textura


func _ready() -> void:
	var estrelasTotal = 0 # Número total de estrelas
	# percorre as recompensas de cada nivel, pelo nome
	for levelName in SaveManager.recompensaLevels.keys():
		var levelNum = levelName.get_slice("_", 1).to_int() # recebe o indice do level
		
		# recebe as estrelas que o jogador conquistou no level
		var estrelas = SaveManager.progress.get(levelName, {}).get("estrelas",0) 
		
		estrelasTotal += estrelas # soma ao total de estrelas
		
		var containerPath: String = ""
		# Verifica a qual coluna no grid do seletor o level faz parte, a fim de escolher o path correto
		if (levelNum-1)%3 == 0:
			containerPath = "HBoxContainer/VBoxContainer/estrelas_%d" % levelNum
		elif (levelNum-2)%3 == 0:
			containerPath = "HBoxContainer/VBoxContainer2/estrelas_%d" % levelNum
		elif (levelNum-3)%3 == 0:
			containerPath = "HBoxContainer/VBoxContainer3/estrelas_%d" % levelNum
		else:
			containerPath = "HBoxContainer/VBoxContainer%d/estrelas_%d" % [levelNum,levelNum]
		
		var containerEstrelas = get_node(containerPath) # instancia o container
		
		# Percorre as estrelas do container
		for i in range(1,4):
			# verifica se existe
			if containerEstrelas.has_node("estrela_%d" % i):
				# instancia estrela
				var estrela := containerEstrelas.get_node("estrela_%d" % i) as TextureRect
				# verifica se o jogador conquistou essa estrela
				if i <= estrelas:
					estrela.texture = estrelaText # troca a textura
					
	estrelas_label.text = "   x%d" % estrelasTotal # Atualiza texto


func _process(delta: float) -> void:
	pass


# Volta para o menu
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/hud e menus/menu.tscn")


# Leva para area_1
func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_2.tscn")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_3.tscn")


func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_4.tscn")


func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_5.tscn")


func _on_level_6_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_6.tscn")


func _on_level_7_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_7.tscn")


func _on_level_8_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_8.tscn")


func _on_level_9_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_9.tscn")


func _on_level_10_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/fase_10.tscn")
