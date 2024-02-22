extends BaseState

@export var time_deform : float = 1.5
var flag : bool = false

func _ready():
	_name = "ek_deform"

func enter():
	flag = false
	$Timer.wait_time = time_deform
	$Timer.start()

func update():
	check_for_switch()

func check_for_switch():
	if flag:
		if (character.velocity != Vector2.ZERO):
			switch(state_factory.get_state("p_run"))
		else:
			switch(state_factory.get_state("p_idle"))

func _on_timer_timeout():
	flag = true
