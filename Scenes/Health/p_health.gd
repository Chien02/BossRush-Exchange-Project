extends HealthSystem

func _ready():
	init_health()
	Global.p_health = self
	character.get_node("Animation/Normal Mode").material["shader_parameter/flash"] = false

func _on_hurtbox_area_entered(area):
	if (area.is_in_group("Boss") and area.name == "Hurtbox"):
		hurt(area.get_parent().damage)
		knockback(area.owner.last_velocity, 12)
		invisible()
	
	elif (area.is_in_group("Weapon") and area.is_in_group("Boss")):
		var boss = get_tree().get_first_node_in_group("Boss")
		hurt(boss.bag.weapon.damage)
		knockback(boss.last_velocity, 17)
		invisible()
	
	elif (area.is_in_group("Boss")):
		var boss = get_tree().get_first_node_in_group("Boss")
		print("boss.damage: ", boss.damage)
		hurt(boss.damage)
		knockback(boss.last_velocity, 20)
		invisible()


func invisible():
	character.get_node("Hurtbox").collision_mask = 0b000 | 0b000
	await get_tree().create_timer(2).timeout
	character.get_node("Hurtbox").collision_mask = 0b010 | 0b100
