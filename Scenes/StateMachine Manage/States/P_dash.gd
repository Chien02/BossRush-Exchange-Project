extends BaseState
# dash state

@export var last_speed := 100
var dashing : bool = false
var shadow_clone # spawn a shadow behind player
var dashing_speed := 500
var press_attack_while_dash : bool = false

func enter():
	print("I'm dash")
	dashing = true
	$Timer.start()
	$Timer2SpawnShadow.start()
	
func exit():
	character.SPEED = last_speed

func update():
	if (!character) : return # Khong tim thay
	handle_dash()
	check_for_switch()

func check_for_switch():
	if (!dashing):
		$Timer2SpawnShadow.stop()
		character.block_direction = false
		if (press_attack_while_dash):
			press_attack_while_dash = false
			switch(state_factory.get_state("p_attack"))
		else:
			switch(state_factory.get_state("p_idle"))
			

func handle_dash():
	# For the next action
	if (Input.is_action_just_pressed("attack")):
		press_attack_while_dash = true
	# For the real dash
	Global.camera.shake(0.05, 1.5)
	get_tree().create_tween().tween_property(character, "position", character.position + character.direction * 30, $Timer.wait_time).set_ease(Tween.EASE_IN)

func _on_timer_timeout():
	dashing = false

# For the effects
func _on_timer_2_spawn_shadow_timeout():
	shadow_clone = preload("res://Scenes/Effects/shadow_clone.tscn").instantiate()
	get_tree().current_scene.add_child(shadow_clone)
	shadow_clone.position = character.position
