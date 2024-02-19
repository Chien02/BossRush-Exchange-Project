extends BaseState

var attacking : bool = false
var play_animation : bool = false
var cancel : bool = false

func enter():
	_name = "boss_attack"
	attacking = true
	play_animation = false
	$Timer.start()

func exit():
	if (character):
		character.attack = false

func update():
	handle_atk()
	check_for_switch()

func check_for_switch():
	if (!attacking or !character.attack):
		if (character.sweep):
			switch(state_factory.get_state("boss_sweep"))
		else:
			switch(state_factory.get_state("boss_idle"))

func handle_atk():
	if (!character.bag): return
	if (!character.bag.weapon): return
	var _direction = (character.target.position - character.position).normalized()
	var weapon = character.bag.weapon
	$Timer.wait_time = weapon.b_time
	if (weapon.cancel):
		weapon.cancel = false
		attacking = false
		return
	
	weapon.animation(true, false) # true is normal atk, false is boss
	weapon.set_direction(_direction, false) # false is boss

func _on_timer_timeout():
	attacking = false
