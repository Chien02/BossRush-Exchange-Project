extends BaseState
# E_chase state

var chasing : bool = false
var attacking : bool = false

func enter():
	_name = "e_chase"
	print(_name)
	
func exit():
	character.velocity = Vector2.ZERO

func update():
	if (!character): return
	handle_chase()
	check_for_switch()

func check_for_switch():
	if (character.attack == true):
		switch(state_factory.get_state("e_attack"))

func handle_chase():
	var delta : float = 0.8
	if (!character.player): return
	var target_pos = (character.player.position - character.position).normalized()
	
	if character.position.distance_to(character.player.position) > 3:
		character.velocity = character.velocity.move_toward(character.SPEED * target_pos, delta)
		clamp(character.SPEED, 50, character.SPEED)
		character.move_and_slide()
		look_at(character.player.position)
	
