extends HealthSystem

var flash : bool = false

func _ready():
	init_health()
	Global.b_health = self
	character.get_node("Animation/AnimatedSprite2D").material["shader_parameter/flash"] = false

func _process(_delta):
	if current_health == 0:
		death = true
	if (is_hurting):
		character.get_node("Hurtbox/CollisionShape2D").disabled = true
		character.get_node("Hurtbox/CollisionShape2D2").disabled = true
		handle_hurt()
	else:
		character.get_node("Hurtbox/CollisionShape2D").disabled = false
		character.get_node("Hurtbox/CollisionShape2D2").disabled = false

func _on_hurtbox_area_entered(area):
	if (area.owner.is_in_group("Weapon") and area.owner.name == "Lighting Sword"):
		$Timer.start()
		$FlashyTime.start()
		Global.camera.shake(0.07, 2)
		Global.frame_freeze(0.1, 0.2)
		var weapon = area.owner
		hurt(weapon.damage)
		knockback(weapon.get_parent().get_parent().velocity, 10)

func handle_hurt():
	var delta : float = 0.75
	character.velocity = lerp(character.velocity, Vector2.ZERO, delta)
	var _material = character.get_node("Animation/AnimatedSprite2D").material
	character.get_node("b_slot/TreeHammer/AnimatedSprite2D").material = _material
	character.get_node("b_slot/TreeHammer/AnimatedSprite2D").material["shader_parameter/flash"] = flash

func _on_timer_timeout():
	is_hurting = false
	$FlashyTime.stop()
	flash = false
	character.get_node("b_slot/TreeHammer/AnimatedSprite2D").material["shader_parameter/flash"] = flash
	
func _on_flashy_time_timeout():
	flash = !flash
