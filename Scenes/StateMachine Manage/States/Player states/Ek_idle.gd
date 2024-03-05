extends BaseState

# Ek idle
func _ready():
	_name = "ek_idle"

func exit():
	pass

func update():
	if (!character): return #state machine ko cung cấp được người chơi
	handle_idle()
	check_for_switch()

func check_for_switch():
	# If do to dash or go to attack, then block the direction
	# hurt
	if (character.get_node("Player Health").is_hurting):
		switch(state_factory.get_state("ek_hurt"))
	# ek time out
	if (character.ek.ek_mode == false):
		switch(state_factory.get_state("ek_deform"))
	# ek special
	if (Input.is_action_just_pressed("ek")):
		switch(state_factory.get_state("ek_special"))
	# dash
	if (Input.is_action_just_pressed("dash")):
		switch(state_factory.get_state("ek_dash"))
	# attack
	if (character.attack):
		switch(state_factory.get_state("ek_attack"))
	
	if (character.velocity != Vector2.ZERO):
		switch(state_factory.get_state("ek_run"))

func handle_idle():
	pass
