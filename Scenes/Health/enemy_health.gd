extends HealthSystem


func _on_hurtbox_area_entered(area):
	if (area.is_in_group("Player") or area.is_in_group("Weapon")):
		hurt(area.get_parent().damage)
