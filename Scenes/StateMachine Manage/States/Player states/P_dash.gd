extends BaseState
# dash state

@export var last_speed := 100
var dashing : bool = false
var shadow_clone # spawn a shadow behind player
var dashing_speed := 500
var press_attack_while_dash : bool = false

func enter():
	_name = "dash"
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
	if (!dashing):
		$Timer2SpawnShadow.stop()
		if (press_attack_while_dash):
			press_attack_while_dash = false
			switch(state_factory.get_state("p_attack"))
		else:
			switch(state_factory.get_state("p_idle"))
			

func handle_dash():
	# For the next action
	if (Input.is_action_just_pressed("attack")):
		press_attack_while_dash = true
	
	get_tree().create_tween().tween_property(character, # For the real dash, do animation
		"position",
		character.position + character.animation_control.animation_tree["parameters/Dash/blend_position"].normalized() * 25,
		$Timer.wait_time).set_ease(Tween.EASE_IN)
	

func _on_timer_timeout():
	dashing = false # If time out, dashing cannot do anymore

# For the effects
func _on_timer_2_spawn_shadow_timeout():
	# Use Ghosting technic, spawn the shadow to the screen
	shadow_clone = preload("res://Scenes/Effects/shadow_clone.tscn").instantiate()
	if (!get_tree().current_scene): return
	get_tree().current_scene.add_child(shadow_clone)
	var animated= character.get_child(4).get_child(1)
	var current_frame = animated.frame
	shadow_clone.texture = animated.get_sprite_frames().get_frame_texture(animated.animation, current_frame) # first child is Animation node, second child: Animated Sprite
	shadow_clone.position = character.position # Set the position of the shadow is behind player
