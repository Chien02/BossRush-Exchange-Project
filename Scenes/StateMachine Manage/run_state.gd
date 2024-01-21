extends BaseState
# run_state.id

func enter():
	print("I'm run")
	
func exit():
	print("Run goodbye")

func update():
	if (!player): return
	handle_run()
	check_for_switch()

func check_for_switch():
	if (player.direction == Vector2.ZERO):
		switch(state_factory.get_state("idle"))

func handle_run():
	print("U r in run")
