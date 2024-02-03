extends HealthSystem


func _on_hurtbox_area_entered(area):
	if (area.is_in_group("Player") or area.is_in_group("Weapon")):
		hurt(area.get_parent().damage)
		knockback(area.get_parent().get_parent().get_parent().velocity, 5)


