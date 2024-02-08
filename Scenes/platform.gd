extends CanvasLayer

var platform : bool = false

func _ready():
	Global.platform = platform

func _process(_delta):
	Global.platform = platform

func _on_mobile_button_down():
	platform = true
	Global.platform = platform
	go_to_main_menu()

func _on_pc_button_down():
	platform = false
	Global.platform = platform
	go_to_main_menu()

func go_to_main_menu():
	var next_scene = "res://Scenes/menu/main_menu.tscn"
	SceneTransition.fade_out(next_scene)
