extends BaseState
# run_state.id

func enter():
	_name = "run"
	
func exit():
	pass

func update():
	if (!character): return
	handle_run()
	check_for_switch()

func check_for_switch():
	# dash
	if (character.get_child(5).is_hurting):
		switch(state_factory.get_state("p_hurt"))
	
	if (Input.is_action_just_pressed("ui_accept")):
		switch(state_factory.get_state("p_dash"))
	# attack
	if (Input.is_action_just_pressed("attack")): #esc
		switch(state_factory.get_state("p_attack"))
		
	if (character.velocity == Vector2.ZERO):
		switch(state_factory.get_state("p_idle"))

func handle_run():
	pass
