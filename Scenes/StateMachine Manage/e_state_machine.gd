extends StateMachine

func _ready():
	# Set new variables for enemy
	base_state = $"Base State"
	state_factory = $StateFactory
	
	current_state = state_factory.get_state("e_chase")
	get_info()
	current_state.enter()
