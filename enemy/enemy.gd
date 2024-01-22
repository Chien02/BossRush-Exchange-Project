extends CharacterBody2D
class_name TestEnemy

func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		print("play-enemy")

 	
