extends CanvasLayer


func _ready() -> void:
	visible = false

# Configura "esc" para pausar o jogo
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true


func _process(delta: float) -> void:
	pass


# Retoma o jogo, despausando os nós
func _on_retomar_pressed() -> void:
	visible = false
	get_tree().paused = false

# abre menu de opções
func _on_opcoes_pressed() -> void:
	pass # Fazer menu de opções

# Volta para o menu
func _on_sair_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/hud e menus/menu.tscn")
