extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Global.p_health.death == true):
		$"Game Over".visible = true
		get_tree().paused = true
	if (Global.b_health.death == true):
		$"Game Over".get_node("Label").text = "Winn"
		$"Game Over".visible = true
		get_tree().paused = true


func _on_quit_button_down():
	get_tree().quit()
