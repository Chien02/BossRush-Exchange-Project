extends HealthSystem

func _ready():
	init_health()
	Global.p_health = self

func _on_hurtbox_area_entered(area):
	Global.frame_freeze(0.1, 0.1)
	if (area.is_in_group("Boss") and area.name == "Hurtbox"):
		hurt(area.get_parent().damage)
		knockback(area.owner.last_velocity, 12)
		
	elif (area.is_in_group("Boss") and area.name == "Hitbox"):
		hurt(area.owner.damage)
		knockback(area.get_parent().last_velocity, 20)
