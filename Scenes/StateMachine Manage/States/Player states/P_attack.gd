extends BaseState
#attack state
@export var speed_default := 100
@export var speed_when_attack := 50

var flag : bool = false # use for play animation just 1 time
var weapon : Weapon_base
var attacking : bool = false
var press_dash_while_attack : bool = false
var press_attack_while_attack : bool = false

func enter():
	_name = "attack"
	attacking = true
	$Timer.start()
	
func exit():
	character.SPEED = speed_default
	flag = false

func update():
	if (!character): return
	handle_attack()
	check_for_switch()

func check_for_switch():
	if (character.get_node("Player Health").is_hurting):
		character.bag.weapon.set_attack(false)
		switch(state_factory.get_state("p_hurt"))
		
	if (!attacking):
		if (press_dash_while_attack):
			press_dash_while_attack = false # reset
			reset_atk_animation()
			switch(state_factory.get_state("p_dash"))
		elif (press_attack_while_attack):
			press_attack_while_attack = false
			reset_atk_animation()
			switch(state_factory.get_state("p_attack"))
		else:
			reset_atk_animation()
			switch(state_factory.get_state("p_idle"))

func handle_attack():
	$Timer.wait_time = character.bag.weapon.using_time # Time for using weapon
	character.SPEED = speed_when_attack # Change speed when attack
	if (Input.is_action_just_pressed("dash")): # For next action
		press_dash_while_attack = true
	if (Input.is_action_just_pressed("attack")):
		press_attack_while_attack = true
	
	# check if exsist target
	if (!character.bag): return
	if (!character.bag.weapon): return
	if (!flag):
		flag = true
		character.bag.weapon.set_attack(true)
		character.bag.weapon.play_animation()

func reset_atk_animation():
	if (character.bag): 
		character.bag.weapon.set_attack(false)

func _on_timer_timeout():
	attacking = false
