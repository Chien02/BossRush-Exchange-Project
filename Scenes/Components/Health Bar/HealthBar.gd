extends ProgressBar

@onready var timer  = $Timer
@onready var damageBar = $DamageBar

var health = 0 : set = _set_health


func _set_health(new_health):
	var pre_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		print("Dead")
	
	if health < pre_health:
		timer.start()
	else:
		damageBar.value = health
		
	
func initHealth(_health):
	health = _health
	max_value = health
	value = health
	damageBar.max_value = health
	damageBar.value = health


func _on_timer_timeout():
	damageBar.value = health  
