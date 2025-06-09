extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retomar_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_opcoes_pressed() -> void:
	pass # Fazer menu de opções


func _on_sair_pressed() -> void:
	get_tree().quit() # enquanto não tem menu principal
