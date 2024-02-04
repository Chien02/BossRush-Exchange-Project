extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	if (Global.b_health):
		max_value = Global.b_health.max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Global.b_health):
		value = Global.b_health.current_health
