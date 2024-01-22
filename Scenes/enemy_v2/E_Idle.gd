extends BaseState

func enter():
	print("E - Idle")
	
func exit():
	pass

func update():
	if !player :
		return
	handle_Idle()
	check_for_switch()

func check_for_switch():
	if(player.chase):
		pass

func handle_Idle():
	pass
