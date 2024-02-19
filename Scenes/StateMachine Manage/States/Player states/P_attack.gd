extends BaseState
#attack state
@export var speed_default := 100
@export var speed_when_attack := 50

var input : bool = true # true = normal attack, false = skill
var attacking : bool = false
var press_dash_while_attack : bool = false
var press_attack_while_attack : bool = false

func enter():
	_name = "attack"
	attacking = true
	$Timer.start()
	
func exit():
	character.SPEED = speed_default
	if (character):
		character.attack = false

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
			switch(state_factory.get_state("p_dash"))
		elif (press_attack_while_attack):
			press_attack_while_attack = false
			switch(state_factory.get_state("p_attack"))
		else:
			switch(state_factory.get_state("p_idle"))

func handle_attack():
	character.SPEED = speed_when_attack # Change speed when attack
	if (Input.is_action_just_pressed("dash")): # For next action
		press_dash_while_attack = true
	if (Input.is_action_just_pressed("attack")):
		press_attack_while_attack = true
	
	# check if exsist target
	if (!character.bag): return
	if (!character.bag.weapon): return
	
	var _direction = Vector2.ZERO
	var weapon = character.bag.weapon
	$Timer.wait_time = weapon.p_time
	if (character.target):
		_direction = (character.target.position - character.position).normalized()
	if (weapon.cancel):
		weapon.cancel = false
		attacking = false
		return
	
	weapon.animation(true, true) # true is normal atk, true is player
	weapon.set_direction(_direction, true) # true is player

func _on_timer_timeout():
	attacking = false
