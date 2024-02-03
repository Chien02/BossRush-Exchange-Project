extends BaseState

var idling : bool = false

func enter():
	_name = "boss_idle"
	idling = true
	$Timer.start()
	
func exit():
	pass

func update():
	if (!character): return
	handle_idle()
	check_for_switch()

func check_for_switch():
	if (character.get_node("Boss_health").is_hurting):
		switch(state_factory.get_state("boss_hurt"))
	if (!idling):
		if (character.sweep):
			switch(state_factory.get_state("boss_sweep"))
		else:
			switch(state_factory.get_state("boss_chase"))

func handle_idle():
	pass

func _on_timer_timeout():
	idling = false
