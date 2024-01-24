extends Node2D

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.5).set_ease(Tween.EASE_IN)
	await tween.finished
	queue_free()
