extends HealthSystem

func _ready():
	init_health()


func _on_hurtbox_area_entered(area):
	if (area.owner.is_in_group("Player")):
		var weapon = area.owner
		hurt(weapon.damage)
		knockback(weapon.get_parent().get_parent().velocity, 10)
