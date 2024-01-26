extends HealthSystem

func _ready():
	init_health()
	#health_bar = get_tree().get_nodes_in_group("Healthbar")[0]

func _on_hurtbox_area_entered(area):
	hurt(area.get_parent().damage)
	var tween = create_tween()
	tween.tween_property($"../Animation/AnimatedSprite2D", "modulate", Color.DARK_RED, 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($"../Animation/AnimatedSprite2D", "modulate", Color(1, 1, 1, 1), 0.1).set_trans(Tween.TRANS_ELASTIC)
	Global.camera.shake(0.05, 2)
