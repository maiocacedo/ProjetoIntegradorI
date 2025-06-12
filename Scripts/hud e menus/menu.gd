extends Control



func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


# Leva para seletor de niveis
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")

# Leva para créditos
func _on_créditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/HUD/creditos.tscn")

# Leva para opções
func _on_opcoes_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/HUD/opcoes.tscn")

# Sai do jogo
func _on_sair_pressed() -> void:
	get_tree().quit()
