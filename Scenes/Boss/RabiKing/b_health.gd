extends HealthSystem

var flash : bool = true

func _ready():
	Global.b_health = self
	init_health()
	character.get_node("Animation/AnimatedSprite2D").material["shader_parameter/flash"] = false

func _process(_delta):
	if current_health == 0:
		death = true
	if (is_hurting):
		character.get_node("Hurtbox/Lower").disabled = true
		character.get_node("Hurtbox/Upper").disabled = true
		handle_hurt()
	else:
		character.get_node("Hurtbox/Lower").disabled = false
		character.get_node("Hurtbox/Upper").disabled = false

func _on_hurtbox_area_entered(area):
	if (area.is_in_group("Weapon") and area.is_in_group("Player")):
		$Timer.start()
		$FlashyTime.start()
		flash = true
		Global.camera.shake(0.2, 2.5)
		# For energy bar
		if (Global.player_energy.energy < Global.player_energy.max_energy):
			Global.player_energy.add_energy(1)
		Global.frame_freeze(0.1, 0.2)
		Global.zoom(0.2)
		var weapon = get_tree().get_first_node_in_group("Player").bag.weapon
		hurt(weapon.damage)
		knockback(weapon.get_parent().get_parent().velocity, 10)
		

func handle_hurt():
	var delta : float = 0.75
	character.velocity = lerp(character.velocity, Vector2.ZERO, delta)
	var _material = character.get_node("Animation/AnimatedSprite2D").material
	if (character.bag.weapon):
		if (character.bag.weapon.name == "TreeHammer"):
			character.get_node("b_slot/TreeHammer/Boss/BossAnimated").material = _material
			character.get_node("b_slot/TreeHammer/Boss/BossAnimated").material["shader_parameter/flash"] = flash
	character.get_node("Animation/AnimatedSprite2D").material["shader_parameter/flash"] = flash

func _on_timer_timeout():
	is_hurting = false
	$FlashyTime.stop()
	flash = false
	if (character.bag.weapon):
		if (character.bag.weapon.name == "TreeHammer"):
			character.get_node("b_slot/TreeHammer/Boss/BossAnimated").material["shader_parameter/flash"] = flash
	character.get_node("Animation/AnimatedSprite2D").material["shader_parameter/flash"] = false
	
func _on_flashy_time_timeout():
	flash = !flash
