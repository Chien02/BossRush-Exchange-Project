extends BaseState

var attacking : bool = false
var play_animation : bool = false

func enter():
	_name = "boss_attack"
	attacking = true
	play_animation = false
	$Timer.start()
	$Ready2atk.start()

func exit():
	character.attack = false

func update():
	handle_atk()
	check_for_switch()

func check_for_switch():
	if (!attacking):
		if (character.sweep):
			reset_atk_animation()
			switch(state_factory.get_state("boss_sweep"))
		else:
			reset_atk_animation()
			switch(state_factory.get_state("boss_idle"))

func handle_atk():
	if (!character.bag): return
	if (!character.bag.weapon): return
	character.bag.weapon.set_attack(true)
	if (!play_animation):
		play_animation = true
		character.bag.weapon.play_animation()
	
	character.get_node("Hammer Zone/Hammer").disabled = attacking

func reset_atk_animation():
	if (character.bag): 
		character.bag.weapon.set_attack(false)

func _on_timer_timeout():
	attacking = false

func _on_ready_2_atk_timeout():
	character.bag.weapon.rotate_to_target(character.bag.weapon.target)
