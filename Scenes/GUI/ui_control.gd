extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	manage_mobile()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	manage_mobile()
	if (Global.p_health.death == true):
		$"Game Over".visible = true
		get_tree().paused = true
	if (Global.b_health.death == true):
		$"Game Over".get_node("Label").text = "Winn"
		$"Game Over".visible = true
		get_tree().paused = true


func manage_mobile():
	$ForMobile.visible = true if Global.platform == true else false

func _on_quit_button_down():
	var next_scene = "res://Scenes/menu/main_menu.tscn"
	SceneTransition.fade_out(next_scene)
