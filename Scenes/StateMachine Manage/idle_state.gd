extends BaseState
# Idle_state.gd

func enter():
	print("Idle hello")
	
func exit():
	pass

func update():
	check_for_switch()
	pass

func check_for_switch():
	pass

func switch(_new_state):
	pass
