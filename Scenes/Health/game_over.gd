extends Control


func _ready():
	visible = get_tree().paused

func _on_player_health_dead():
	get_tree().paused = true
	visible = get_tree().paused
	


func _on_label_button_down():
	get_tree().paused = false
	get_tree().reload_current_scene()
