extends BaseState
# Idle_state.gd

func enter():
	print("Hello i'm idle")
	
func exit():
	print("Idle goodbye")

func update():
	if (!player): return
	handle_ilde()
	check_for_switch()

func check_for_switch():
	if (player.direction != Vector2.ZERO):
		switch(state_factory.get_state("run"))

func handle_ilde():
	print("U r in ilde")
