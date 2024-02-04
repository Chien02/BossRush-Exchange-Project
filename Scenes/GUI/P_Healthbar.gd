extends TextureProgressBar

func _ready():
	if (Global.p_health):
		max_value = Global.p_health.max_health

func _process(_delta):
	if (Global.p_health):
		value = Global.p_health.current_health
