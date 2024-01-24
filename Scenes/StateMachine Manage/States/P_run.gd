extends BaseState
# run_state.id

func enter():
	print("I'm run")
	
func exit():
	pass

func update():
	if (!character): return
	handle_run()
	check_for_switch()

func check_for_switch():
	# dash
	if (Input.is_action_just_pressed("ui_accept")):
		character.block_direction = true
		switch(state_factory.get_state("p_dash"))
	# attack
	if (Input.is_action_just_pressed("attack")): #esc
		character.block_direction = true
		switch(state_factory.get_state("p_attack"))
		
	if (character.velocity == Vector2.ZERO):
		switch(state_factory.get_state("p_idle"))

func handle_run():
	pass
