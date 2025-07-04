extends CanvasLayer

@onready var opcoes = $opcoes
@onready var congratulacoes = $"../menu_de_congratulacoes"

func _ready() -> void:
	visible = false
	opcoes.visible = false

# Configura "esc" para pausar o jogo
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and congratulacoes.visible != true:
		visible = true
		get_tree().paused = true
		MusicManager._stop_music()

func _process(delta: float) -> void:
	pass

# Retoma o jogo, despausando os nós
func _on_retomar_pressed() -> void:
	visible = false
	get_tree().paused = false
	MusicManager.retomar_musica()

# abre menu de opções
func _on_opcoes_pressed() -> void:
	opcoes.visible = true

# Volta para o menu
func _on_sair_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/hud e menus/menu.tscn")
