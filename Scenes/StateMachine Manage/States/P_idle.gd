extends BaseState
# Idle_state.gd

func enter():
	print("I'm idle")
	
func exit():
	pass

func update():
	if (!character): return #state machine ko cung cấp được người chơi
	handle_ilde()
	check_for_switch()

func check_for_switch():
	# If do to dash or go to attack, then block the direction
	#dash
	if (Input.is_action_just_pressed("ui_accept")):
		character.block_direction = true
		switch(state_factory.get_state("p_dash"))
	# attack
	if (Input.is_action_just_pressed("attack")): #esc
		character.block_direction = true
		switch(state_factory.get_state("p_attack"))
		
	if (character.velocity != Vector2.ZERO):
		switch(state_factory.get_state("p_run"))

func handle_ilde():
	pass
