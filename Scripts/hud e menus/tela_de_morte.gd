extends CanvasLayer

@onready var voce_perdeu_label = $menu_morte/voce_perdeu_label

func _ready() -> void:
	mostrar_morte()

# mostra a tela e atualiza texto
func mostrar_morte():
	visible = true
	voce_perdeu_label.text = GameManager.last_death_cause


func _process(delta: float) -> void:
	pass

# Recarrega fase
func _on_tentar_novamente_pressed() -> void:
	# se o path estiver correto, recarrega cena anterior
	if GameManager.last_scene_path != "":
		get_tree().change_scene_to_file(GameManager.last_scene_path)
		MusicManager.retomar_musica()
	else: 
		push_error("lastScenePath não existe")
	

# Volta para o menu
func _on_voltar_menu_principal_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")
