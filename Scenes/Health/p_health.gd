extends HealthSystem

func _ready():
	init_health()
	Global.p_health = self
	character.get_node("Animation/AnimatedSprite2D").material["shader_parameter/flash"] = false

func _on_hurtbox_area_entered(area):
	Global.frame_freeze(0.1, 0.1)
	if (area.is_in_group("Boss") and area.name == "Hurtbox"):
		hurt(area.get_parent().damage)
		knockback(area.owner.last_velocity, 12)
		
	elif (area.is_in_group("Boss") and area.name == "Hitbox"):
		var boss = get_tree().get_first_node_in_group("Boss")
		hurt(boss.damage)
		knockback(boss.last_velocity, 20)
	
	elif (area.is_in_group("Weapon") and area.name == "Hitbox"):
		var boss = get_tree().get_first_node_in_group("Boss")
		hurt(boss.bag.weapon.damage)
		knockback(boss.last_velocity, 17)
