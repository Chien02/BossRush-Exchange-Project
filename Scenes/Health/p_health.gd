extends HealthSystem

func _ready():
	init_health()
	#health_bar = get_tree().get_nodes_in_group("Healthbar")[0]

func _on_hurtbox_area_entered(area):
	if (area.is_in_group("Boss") and area.name == "Hurtbox"):
		hurt(area.get_parent().damage)
		knockback(-character.velocity, 12)
		
	if (area.is_in_group("Boss") and area.name == "Hitbox"):
		print(area.name)
		hurt(area.owner.damage)
		knockback(area.get_parent().last_velocity, 20)
