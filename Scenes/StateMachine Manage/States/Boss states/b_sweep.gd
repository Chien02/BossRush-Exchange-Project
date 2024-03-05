extends BaseState

var sweeping : bool = false

func enter():
	_name = "boss_sweep"
	sweeping = true
	$Timer.start()
	
func exit():
	pass

func update():
	if (!character): return
	handle_sweep()
	check_for_switch()

func check_for_switch():
	if (character.be_eked):
		sweeping = false
		switch(state_factory.get_state("boss_be_eked"))
	if (!sweeping):
		switch(state_factory.get_state("boss_idle"))

func handle_sweep():
	pass

func _on_timer_timeout():
	sweeping = false
