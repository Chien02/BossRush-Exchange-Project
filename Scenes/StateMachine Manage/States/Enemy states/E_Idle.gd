extends BaseState

func enter():
	print("E - Idle")
	
func exit():
	pass

func update():
	if !character :
		return
	handle_Idle()
	check_for_switch()

func check_for_switch():
	#if(character.chase):
		#pass
	pass

func handle_Idle():
	pass
