extends BaseState
#attack state
var attacking : bool = false
@onready var timer = $Timer

func enter():
	print("toi la attack")
	
func exit():
	pass

func update():
	if (!player): return
	handle_attack()
	check_for_switch()

func check_for_switch():
	if (!attacking):
		switch(state_factory.get_state("idle"))

func handle_attack():
	if (timer.timeout):
		attacking = false
