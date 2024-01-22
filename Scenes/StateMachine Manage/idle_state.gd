extends BaseState
# Idle_state.gd

func enter():
	print("Idle")
	
func exit():
	pass

func update():
	if (!player): return #state machine ko cung cấp được người chơi
	handle_ilde()
	check_for_switch()

func check_for_switch():
	#dash
	if (Input.is_action_just_pressed("ui_accept")):
		switch(state_factory.get_state("dash"))
	# attack
	if (Input.is_action_just_pressed("attack")): #esc
		switch(state_factory.get_state("attack"))
		
	if (player.direction != Vector2.ZERO):
		switch(state_factory.get_state("run"))

func handle_ilde():
	pass
