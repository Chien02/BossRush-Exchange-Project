extends BaseState

@export var special_time : float = 0.667

var specialing : bool = false

func _ready():
	_name = "ek_special"

func enter():
	specialing = true
	$Timer.wait_time = special_time
	$Timer.start()
	
func exit():
	specialing = false

func update():
	handle_special()
	check_for_switch()

func handle_special():
	character.SPEED = 30
	var anim = character.animation_control
	var aim_system = character.get_node("Aim system")
	anim.animation_tree["parameters/ek_special/blend_position"] = aim_system.rotate_to_target()
	

func check_for_switch():
	if (!specialing):
		character.SPEED = 120
		if (character.velocity == Vector2.ZERO):
			switch(state_factory.get_state("ek_idle"))
		else:
			switch(state_factory.get_state("ek_run"))

func _on_timer_timeout():
	specialing = false
