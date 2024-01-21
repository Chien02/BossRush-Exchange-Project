extends Node2D

class_name BaseState

@export var state_machine : StateMachine
@export var state_factory : StateFactory

var player : Player

func _ready():
	player = state_machine.player_control if (state_machine.player_control) else null

func check_player():
	if (player): return true
	else: return false

func enter():
	pass
	
func exit():
	pass

func update():
	pass

func check_for_switch():
	pass

func switch(_new_state: BaseState):
	_new_state.enter()
	state_machine.current_state.exit()
	state_machine.current_state = _new_state
