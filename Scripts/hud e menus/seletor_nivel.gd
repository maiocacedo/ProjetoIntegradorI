extends Control



func _ready() -> void:
	pass # Adicionar verificacao de estrelas


func _process(delta: float) -> void:
	pass

# Leva para area_1
func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Areas/area_1.tscn")

# Volta para o menu
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/hud e menus/menu.tscn")
