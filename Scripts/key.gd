extends Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var item: InvItem
var player = null

func _on_body_entered(body: Node2D) -> void:
	player = body
	if body.name == "CharacterBody2D":
		var tween = create_tween()
		
		tween.tween_property(self , "position" , position + Vector2(0 , -30), 1)
		
		tween.tween_property(self , "modulate:a" ,0 , 0.5)
		tween.tween_callback(self.queue_free)
		
		player.collect(item)
