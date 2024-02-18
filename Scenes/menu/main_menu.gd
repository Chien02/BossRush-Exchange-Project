extends CanvasLayer

func _ready():
	$Control2/Control/AnimatedSprite2D.visible = false

func change_scene():
	$Control2/Control.visible = false
	$Control2/background.visible = false
	$Control2/icon.visible = false
	var next_scene = "res://Scenes/loading_scene.tscn"
	$Control2/Control/AnimatedSprite2D.visible = false
	SceneTransition.fade_out(next_scene)

func _on_quit_button_down():
	pass

func _on_start_button_down():
	var animator = $Control2/Control/AnimationPlayer
	$Control2/Control/AnimatedSprite2D.visible = true
	animator.play("default")
	$Control2/Start.visible = false
