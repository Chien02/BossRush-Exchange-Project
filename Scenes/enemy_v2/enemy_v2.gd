extends CharacterBody2D

var chase : bool = false

func _on_area_2d_body_entered(body):
	chase = true

func _on_area_2d_body_exited(body):
	chase = false
