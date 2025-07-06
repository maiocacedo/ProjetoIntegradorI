extends Control

@onready var estrelas_label = $estrelas_label # Numero de estrelas adquiridas

var estrelaPath = "res://Assets/sprites/estrela.png" # Caminho da estrela
var estrelaText : Texture2D = load(estrelaPath) # Carregando estrela como textura


func _ready() -> void:
	var total_estrelas := 0
	
	for levelName in SaveManager.recompensaLevels.keys():
		var levelNum   = levelName.get_slice("_", 1).to_int()
		var estrelas   = SaveManager.progress.get("fases").get(levelName, {}).get("estrelas", 0)
		total_estrelas += estrelas
		

		var colIdx   = (levelNum - 1) % 3 + 1
		var vboxName = "VBoxContainer%d" % colIdx
		
		# 2) Path até o container de estrelas daquela fase
		var estrelasContPath = "HBoxContainer/%s/estrelas_%d" % [vboxName, levelNum]
		if has_node(estrelasContPath):
			var cont = get_node(estrelasContPath)
			# acende ou apaga cada uma das 3 estrelas
			for i in range(1,4):
				var starNode = cont.get_node("estrela_%d" % i) as TextureRect
				if (i<=estrelas):
					starNode.texture = estrelaText

		# 3) Desbloqueia o botão da próxima fase, se tiver conquistado >0 estrelas
		var nextLevel = levelNum + 1
		var nextCol   = (nextLevel - 1) % 3 + 1
		var nextVbox  = "VBoxContainer%d" % nextCol
		var nextBtnPath = "HBoxContainer/%s/level_%d" % [nextVbox, nextLevel]
		if estrelas > 0 and has_node(nextBtnPath):
			get_node(nextBtnPath).disabled = false
			
	PlayerData.stats["estrelas"] = total_estrelas
	estrelas_label.text = "   x%d" % total_estrelas

func _process(delta: float) -> void:
	pass


# Volta para o menu
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/hud e menus/menu.tscn")

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_2.tscn")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_3.tscn")


func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_4.tscn")


func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_5.tscn")


func _on_level_6_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_6.tscn")


func _on_level_7_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_7.tscn")


func _on_level_8_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_8.tscn")


func _on_level_9_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_9.tscn")

func _on_level_10_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fases/fase_10.tscn")

func _on_loja_pressed() -> void:
	var total_estrelas := 0
	
	for levelName in SaveManager.recompensaLevels.keys():
		var levelNum   = levelName.get_slice("_", 1).to_int()
		var estrelas   = SaveManager.progress.get("fases").get(levelName, {}).get("estrelas", 0)
		total_estrelas += estrelas
			
	PlayerData.stats["estrelas"] = total_estrelas

	get_tree().change_scene_to_file("res://Cenas/hud e menus/Store.tscn")
