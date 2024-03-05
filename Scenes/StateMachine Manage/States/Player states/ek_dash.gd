extends BaseState

# Ek dash

@export var last_speed := 125
var dashing : bool = false
var shadow_clone # spawn a shadow behind player
var flag : bool = false
var flag_direction = false
var direction = Vector2.ZERO
var dashing_speed := 100
var press_attack_while_dash : bool = false
var press_ek_while_dash : bool = false

func enter():
	_name = "ek_dash"
	dashing = true
	flag = false
	flag_direction = false
	direction = Vector2.ZERO
	$Timer.start()
	$TeleportTimer.start()
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
		invisible(false)
		switch(state_factory.get_state("ek_deform"))
	if (!dashing):
		if (press_attack_while_dash):
			press_attack_while_dash = false
			switch(state_factory.get_state("ek_attack"))
		elif (press_ek_while_dash):
			press_ek_while_dash = false
			switch(state_factory.get_state("ek_special"))
		else:
			switch(state_factory.get_state("ek_idle"))
			

func handle_dash():
	# character visible
	invisible(true)
	# Set dash's direction
	var slow_when_teloport = 70
	character.SPEED = slow_when_teloport
	if character.direction != Vector2.ZERO:
		if (!flag_direction):
			flag_direction = true
			direction = character.direction
			character.animation_control.animation_tree["parameters/ek_dash/blend_position"] = direction
	if (Input.is_action_just_pressed("ek")):
		press_ek_while_dash = true
		press_attack_while_dash = false
	if (character.attack):
		press_attack_while_dash = true

func _on_timer_timeout():
	dashing = false # If time out, dashing cannot do anymore

func _on_teleport_timer_timeout():
	# teleport
	if !flag:
		flag = true
		var destination = character.position + (character.direction.normalized() * dashing_speed)
		character.position = destination

func invisible(value):
	character.get_node("Hurtbox").get_child(0).disabled = value
