extends HealthSystem

func _ready():
	init_health()
	Global.b_health = self

func _on_hurtbox_area_entered(area):
	if (area.owner.is_in_group("Player")):
		Global.camera.shake(0.05, 3)
		Global.frame_freeze(0.1, 0.2)
		
		var weapon = area.owner
		hurt(weapon.damage)
		knockback(weapon.get_parent().get_parent().velocity, 10)
