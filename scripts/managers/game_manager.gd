extends Node

var lastScenePath: String = ""
var lastDeathCause: String = ""
const telaMortePath := "res://Cenas/hud e menus/tela_de_morte.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# abre tela de morte e registra causa da morte
func abrir_tela_de_morte(causa:String) -> void:
	lastScenePath = get_tree().current_scene.scene_file_path
	lastDeathCause = causa          
	get_tree().change_scene_to_file(telaMortePath)
