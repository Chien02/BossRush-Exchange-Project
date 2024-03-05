extends BaseState

var hurting : bool = false
var can_move : bool = true
var flash : bool = true

func enter():
	_name = "ek_hurt"
	hurting = true
	can_move = false
	flash = true
	$Timer.start()
	$Flinch_time.start()
	$Flash_time.start()
	Global.camera.shake(0.1, 5)

func exit():
	pass
	
func update():
	handle_hurt()
	check_for_switch()

func check_for_switch():
	if !hurting:
		$Flash_time.stop()
		character.get_node("Player Health").is_hurting = false
		var layer2 = 0b001
		var layer4 = 0b011
		character.get_node("Hurtbox").collision_mask = layer2 | layer4
		character.get_node("Animation/Normal Mode").material["shader_parameter/flash"] = false
		# Return to normal mode if ek time out
		if (character.ek.ek_mode == false):
			switch(state_factory.get_state("ek_deform"))
		if (character.direction != Vector2.ZERO):
			switch(state_factory.get_state("ek_run"))
		else:
			switch(state_factory.get_state("ek_idle"))

func handle_hurt():
	character.get_node("Player Health").is_hurting = true
	character.get_node("Hurtbox").collision_mask = 0
	character.get_node("Animation/Normal Mode").material["shader_parameter/flash"] = flash
	if (!can_move):
		character.direction = Vector2.ZERO

func _on_timer_timeout():
	hurting = false

func _on_flinch_time_timeout():
	can_move = true

func _on_flash_time_timeout():
	flash = !flash