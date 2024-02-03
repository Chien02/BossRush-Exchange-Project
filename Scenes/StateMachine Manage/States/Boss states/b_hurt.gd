extends BaseState

var hurting : bool = false
var flash : bool = false

func enter():
	_name = "b_hurt"
	hurting = true
	flash = true
	$Timer.start()
	$FlashTime.start()
	

func exit():
	pass

func update():
	handle_hurt()
	check_for_switch()

func check_for_switch():
	if (!hurting):
		character.get_node("Boss_health").is_hurting = false
		character.get_node("Animation").get_node("AnimatedSprite2D").material["shader_parameter/flash"] = false
		if (character.sweep):
			switch(state_factory.get_state("boss_sweep"))
		else:
			switch(state_factory.get_state("boss_idle"))

func handle_hurt():
	var delta : float = 0.75
	character.velocity = lerp(character.velocity, Vector2.ZERO, delta)
	character.get_node("Animation").get_node("AnimatedSprite2D").material["shader_parameter/flash"] = flash

func _on_timer_timeout():
	hurting = false

func _on_flash_time_timeout():
	flash = !flash
