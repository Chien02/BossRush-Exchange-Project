extends BaseState
# dash state

var dashing : bool = false
@onready var timer = $Timer

func enter():
	print("toi la dash")
	dashing = true
	
func exit():
	pass

func update():
	if (!player) : return # Khong tim thay
	handle_dash()
	check_for_switch()

func check_for_switch():
	if (!dashing):
		switch(state_factory.get_state("idle"))

func handle_dash():
	if (timer.timeout):
		dashing = false
