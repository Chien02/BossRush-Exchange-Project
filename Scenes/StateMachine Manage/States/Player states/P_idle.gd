extends BaseState
# Idle_state.gd

func enter():
	_name = "idle"
	
func exit():
	pass

func update():
	if (!character): return #state machine ko cung cấp được người chơi
	handle_ilde()
	check_for_switch()

func check_for_switch():
	# If do to dash or go to attack, then block the direction
	# hurt
	if (character.get_node("Player Health").is_hurting):
		switch(state_factory.get_state("p_hurt"))
	# dash
	if (Input.is_action_just_pressed("dash")):
		switch(state_factory.get_state("p_dash"))
	# attack
	if (character.attack):
		switch(state_factory.get_state("p_attack"))
	if (character.velocity != Vector2.ZERO):
		switch(state_factory.get_state("p_run"))

func handle_ilde():
	pass
