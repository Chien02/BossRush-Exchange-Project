extends TextureProgressBar


func _process(_delta):
	if (Global.b_health):
		max_value = Global.b_health.max_health
		value = Global.b_health.current_health
