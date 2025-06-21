extends Node

var lastScenePath: String = ""
var lastDeathCause: String = ""
const telaMortePath := "res://Cenas/hud e menus/tela_de_morte.tscn"

func _ready() -> void:
	pass

# Abre a tela de morte e registra a causa da morte
func abrir_tela_de_morte(causa: String) -> void:
	var current_scene = get_tree().get_current_scene()
	if current_scene != null:
		lastScenePath = current_scene.get_scene_file_path()
	else:
		print("Aviso: cena atual não encontrada.")
		lastScenePath = ""
	
	lastDeathCause = causa
	get_tree().change_scene_to_file(telaMortePath)
