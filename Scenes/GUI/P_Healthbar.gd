extends TextureProgressBar

func _process(_delta):
	if (Global.p_health):
		max_value = Global.p_health.max_health
		value = Global.p_health.current_health
