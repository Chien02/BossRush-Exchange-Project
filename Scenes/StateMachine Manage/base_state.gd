extends Node2D

class_name BaseState

@export var state_machine : StateMachine
@export var state_factory : StateFactory

# Các state khác như idle sẽ lấy thông tin của người chơi từ trong Base để làm việc
# input của player trong base sẽ được cung cấp từ state machine, do state machine giao tiếp với
# player
@export var player : CharacterBody2D

func enter():
	pass
	
func exit():
	pass

func update():
	pass

func check_for_switch():
	pass

func switch(_new_state):
	_new_state.enter()
	state_machine.current_state.exit()
	state_machine.current_state = _new_state
