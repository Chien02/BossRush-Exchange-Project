extends BaseState
#attack state
@export var speed_default := 100
@export var speed_when_attack := 50
var weapon
var target
var attacking : bool = false
var press_dash_while_attack : bool = false
var press_attack_while_attacck : bool = false

func enter():
	attacking = true
	$Timer.start()
	
func exit():
	character.SPEED = speed_default

func update():
	if (!character): return
	handle_attack()
	check_for_switch()

func check_for_switch():
	if (!attacking):
		character.bag.weapon.can_attack = false
		if (press_dash_while_attack):
			press_dash_while_attack = false # reset
			switch(state_factory.get_state("p_dash"))
		elif (press_attack_while_attacck):
			press_attack_while_attacck = false
			switch(state_factory.get_state("p_attack"))
		else:
			switch(state_factory.get_state("p_idle"))

func handle_attack():
	character.SPEED = speed_when_attack # Change speed when attack
	if (Input.is_action_just_pressed("dash")): # For next action
		press_dash_while_attack = true
	if (Input.is_action_just_pressed("attack")):
		press_attack_while_attacck = true
	if (character.bag):
		character.bag.weapon.can_attack = true
	
	# check if exsist target
	if (!character.bag.weapon.target): return
	var direction = Vector2.ZERO
	direction = (character.bag.weapon.target.global_position - character.global_position).normalized()
	character.animation_control.get_atk_direction(direction)
	

func _on_timer_timeout():
	attacking = false
