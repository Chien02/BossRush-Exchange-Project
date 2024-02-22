extends BaseState
# ek_run
func _ready():
	_name = "ek_run"

func enter():
	pass
	
func exit():
	pass

func update():
	if (!character): return
	handle_run()
	check_for_switch()

func check_for_switch():
	# dash
	if (character.ek.ek_mode == false):
		switch(state_factory.get_state("ek_deform"))
			
	if (character.get_node("Player Health").is_hurting):
		switch(state_factory.get_state("ek_hurt"))
	
	if (Input.is_action_just_pressed("dash")):
		switch(state_factory.get_state("ek_dash"))
	# attack
	if (character.attack):
		switch(state_factory.get_state("ek_attack"))
		
	if (character.velocity == Vector2.ZERO):
		switch(state_factory.get_state("ek_idle"))

func handle_run():
	pass
