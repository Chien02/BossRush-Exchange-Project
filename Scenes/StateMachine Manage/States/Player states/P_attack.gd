extends BaseState
#attack state
@export var speed_default := 100
@export var speed_when_attack := 50
var weapon
var attacking : bool = false
var press_dash_while_attack : bool = false

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
		character.get_child(0).weapon.end_hit()
		if (press_dash_while_attack):
			press_dash_while_attack = false # reset
			switch(state_factory.get_state("p_dash"))
		else:
			switch(state_factory.get_state("p_idle"))

func handle_attack():
	character.SPEED = speed_when_attack # Change speed when attack
	var direction = character.animation_control.animation_tree["parameters/Attack/blend_position"]
	if (Input.is_action_just_pressed("dash")): # For next action
		press_dash_while_attack = true
	if (character.get_child(0)):
		character.get_child(0).weapon.hit(direction) # use weapon : direction should change to look at target

func _on_timer_timeout():
	attacking = false
