extends StateMachine

func _ready():
	# Set new variables for enemy
	base_state = $"Base State"
	state_factory = $StateFactory
	
	current_state = state_factory.get_state("boss_idle")
	get_info()
	current_state.enter()

func _physics_process(_delta):
	if current_state:
		current_state.physics_update()
