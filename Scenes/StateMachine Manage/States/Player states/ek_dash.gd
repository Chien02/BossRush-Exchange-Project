extends BaseState

# Ek dash

@export var last_speed := 125
var dashing : bool = false
var shadow_clone # spawn a shadow behind player
var dashing_speed := 50
var press_attack_while_dash : bool = false

func enter():
	_name = "ek_dash"
	dashing = true
	$Timer.start()
	$Timer2SpawnShadow.start()
	#Global.camera.shake(0.2, 3) # shake the camera when dash
	
func exit():
	if (character):
		character.SPEED = last_speed

func update():
	if (!character) : return # Khong tim thay
	handle_dash()
	check_for_switch()

func check_for_switch():
	if (character.ek.ek_mode == false):
		dashing = false
		$Timer.stop()
		$Timer2SpawnShadow.stop()
		switch(state_factory.get_state("ek_deform"))
	if (!dashing):
		$Timer2SpawnShadow.stop()
		if (press_attack_while_dash):
			press_attack_while_dash = false
			switch(state_factory.get_state("ek_attack"))
		else:
			switch(state_factory.get_state("ek_idle"))
			

func handle_dash():
	# For the next action
	if (character.attack):
		press_attack_while_dash = true
	
	get_tree().create_tween().tween_property(character, # For the real dash, do animation
		"position",
		character.position + character.direction.normalized() * dashing_speed,
		$Timer.wait_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_timer_timeout():
	dashing = false # If time out, dashing cannot do anymore

# For the effects
func _on_timer_2_spawn_shadow_timeout():
	if (dashing):
		# Use Ghosting technic, spawn the shadow to the screen
		shadow_clone = preload("res://Scenes/Effects/shadow_clone.tscn").instantiate()
		if (!get_tree().current_scene): return
		get_tree().current_scene.add_child(shadow_clone)
		var animated = character.get_node("Animation/Normal Mode") if (!character.ek.ek_mode) else character.get_node("Animation/Ek Mode")
		var frame = animated.sprite_frames.get_frame_texture(animated.animation, animated.frame)
		
		#if (Engine.is_editor_hint()):
		shadow_clone.texture = frame
		shadow_clone.position = character.position + Vector2(0, -6)# Set the position of the shadow is behind player
