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
	if (character.get_node("Player Health").is_hurting):
		switch(state_factory.get_state("p_hurt"))
	
	if (Input.is_action_just_pressed("dash")):
		switch(state_factory.get_state("p_dash"))
	# attack
	if (character.attack):
		switch(state_factory.get_state("p_attack"))
		
	if (character.velocity == Vector2.ZERO):
		switch(state_factory.get_state("p_idle"))

func handle_run():
	pass
