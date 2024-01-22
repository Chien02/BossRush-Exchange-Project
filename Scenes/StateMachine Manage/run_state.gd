extends BaseState
# run_state.id

func enter():
	print("I'm run")
	
func exit():
	pass

func update():
	if (!player): return
	handle_run()
	check_for_switch()

func check_for_switch():
	# dash
	if (Input.is_action_just_pressed("ui_accept")):
		switch(state_factory.get_state("dash"))
	# attack
	if (Input.is_action_just_pressed("attack")): #esc
		switch(state_factory.get_state("attack"))
		
	if (player.direction == Vector2.ZERO):
		switch(state_factory.get_state("idle"))

func handle_run():
	pass
