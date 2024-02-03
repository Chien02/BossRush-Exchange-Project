
extends BaseState
# B_chase state

var chasing : bool = false

func enter():
	_name = "boss_chase"
	chasing = true
	$Timer.start()
	
func exit():
	character.velocity = Vector2.ZERO

func update():
	if (!character): return
	handle_chase()
	check_for_switch()

func check_for_switch():
	if (character.get_node("Boss_health").is_hurting):
		switch(state_factory.get_state("boss_hurt"))
	if (character.sweep):
		switch(state_factory.get_state("boss_sweep"))
	elif (!chasing):
		switch(state_factory.get_state("boss_idle"))

func handle_chase():
	var delta : float = 0.8
	if (!character.player): return
	var target_pos = (character.player.position - character.position).normalized()
	character.velocity = lerp(character.velocity, target_pos * character.SPEED, delta)
	character.move_and_slide()
	look_at(character.player.position)

func _on_timer_timeout():
	chasing = false
