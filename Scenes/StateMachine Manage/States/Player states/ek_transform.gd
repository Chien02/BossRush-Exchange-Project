extends BaseState
# Ek transform
@export var time_transform : float = 1.5
var flag : bool = false

func _ready():
	_name = "ek_transform"

func enter():
	flag = false
	$Timer.wait_time = time_transform
	$Timer.start()

func exit():
	pass

func update():
	check_for_switch()

func physics_update():
	pass

func check_for_switch():
	if flag:
		switch(state_factory.get_state("ek_idle"))


func _on_timer_timeout():
	flag = true
