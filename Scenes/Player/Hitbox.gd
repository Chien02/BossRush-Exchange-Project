extends Area2D

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	look_at(input_vector)
