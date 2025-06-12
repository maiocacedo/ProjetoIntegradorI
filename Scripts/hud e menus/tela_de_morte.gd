extends CanvasLayer

@onready var hud_control = $".."


func _ready() -> void:
	visible = false
	

func _process(delta: float) -> void:
	pass

func _on_tentar_novamente_pressed() -> void:
	print("Tentar")
	get_tree().paused = false
	call_deferred("_reiniciar_jogo")

func _reiniciar_jogo() -> void:
	get_tree().reload_current_scene()	


func _on_voltar_menu_principal_pressed() -> void:
	get_tree().quit() # enquanto não tem menu principal


func _on_hud_times_is_up() -> void:
	visible = true
	get_tree().paused = true
	
