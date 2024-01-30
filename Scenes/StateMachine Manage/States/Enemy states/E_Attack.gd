extends BaseState
# E_attack state

var attack : bool = false

func enter():
	_name = "e_attack"
	attack = true
	$Timer.start()
	
func exit():
	pass

func update():
	if (!character): return
	handle_attack()
	check_for_switch()

func check_for_switch():
	if (attack == false):
		switch(state_factory.get_state("e_chase"))

func handle_attack():
	pass


func _on_timer_timeout():
	attack = false
