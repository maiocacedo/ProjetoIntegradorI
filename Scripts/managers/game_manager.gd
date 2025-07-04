extends Node

# Caminho da tela de morte
const TELA_MORTE_PATH := "res://Cenas/hud e menus/tela_de_morte.tscn"

# Variáveis para guardar o estado antes da morte
var last_scene_path: String = ""
var last_death_cause: String = ""

# Executado quando o nó entra na árvore da cena
func _ready() -> void:
	pass  # Pode ser usado futuramente para lógica de inicialização, se necessário

# Função para abrir a tela de morte e registrar a causa
func abrir_tela_de_morte(causa: String) -> void:
	# Verifica se há uma cena atual carregada antes de acessar sua propriedade
	var cena_atual = self.get_tree().current_scene
	
	if cena_atual != null:
		last_scene_path = cena_atual.scene_file_path
	else:
		last_scene_path = "cena_indefinida"  # Caso não haja uma cena carregada
	
	# Salva a causa da morte
	last_death_cause = causa

	# Muda para a cena da tela de morte
	get_tree().change_scene_to_file(TELA_MORTE_PATH)
