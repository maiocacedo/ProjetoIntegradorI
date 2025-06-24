extends Area2D

# Caminho da primeira label (definido no editor)
@export var label_path: NodePath
# Caminho da segunda label (opcional, definido no editor)
@export var label2_path: NodePath

# Referências para os nós Label
@onready var label: Label = null
@onready var label2: Label = null

# Reprodutor de som associado a este gatilho
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Função executada quando o nó entra na árvore da cena
func _ready() -> void:
	# Verifica se o caminho para a primeira label foi definido e o nó existe
	if label_path != null and has_node(label_path):
		label = get_node(label_path)
		label.visible = false  # Oculta inicialmente

	# Verifica se o caminho para a segunda label foi definido e o nó existe
	if label2_path != null and has_node(label2_path):
		label2 = get_node(label2_path)
		label2.visible = false  # Oculta inicialmente

# Chamado quando um corpo entra na área
func _on_body_entered(body: Node2D) -> void:
	if label:
		label.visible = true
	if label2:
		label2.visible = true

	audio_stream_player_2d.play()  # Toca o som

# Chamado quando um corpo sai da área
func _on_body_exited(body: Node2D) -> void:
	if label:
		label.visible = false
	if label2:
		label2.visible = false
