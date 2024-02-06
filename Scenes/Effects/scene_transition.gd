extends CanvasLayer

@export var animator :AnimationPlayer

func fade_out(_next_scene):
	get_tree().change_scene_to_file(_next_scene)
	animator.play("fade in")

func reset_paused():
	get_tree().paused = false
