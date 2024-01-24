extends BaseState
#attack state
var attacking : bool = false
var press_dash_while_attack : bool = false

func enter():
	attacking = true
	$Timer.start()
	
func exit():
	pass

func update():
	if (!character): return
	handle_attack()
	check_for_switch()

func check_for_switch():
	if (!attacking):
		if (press_dash_while_attack):
			press_dash_while_attack = false # reset
			character.block_direction = false
			switch(state_factory.get_state("p_dash"))
		else:
			character.block_direction = false
			switch(state_factory.get_state("p_idle"))


func handle_attack():
	character.direction = Vector2.ZERO
	if (Input.is_action_just_pressed("dash")):
		press_dash_while_attack = true

func _on_timer_timeout():
	attacking = false
