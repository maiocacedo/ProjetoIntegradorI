extends Area2D
@onready var spikes: Sprite2D = $spikes
@onready var colision: CollisionShape2D = $colision

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
