extends Sprite2D

func _ready():
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.4).set_ease(Tween.EASE_IN)
	await tween.finished
	queue_free()
