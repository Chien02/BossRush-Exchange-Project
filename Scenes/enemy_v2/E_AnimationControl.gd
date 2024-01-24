extends Node2D

@export var state_machine : StateMachine
@export var animation_tree : AnimationTree

func update_paramater_animation(direction):
	get_state()
	get_direction(direction)

func get_state():
	var _state_name = state_machine.current_state._name
	if (_state_name == "e_chase"): set_up_chase(true)
	elif (_state_name == "e_attack"): set_up_attack(true)

func get_direction(_direction):
	if (_direction != Vector2.ZERO):
		animation_tree["parameters/attack/blend_position"] = _direction
		animation_tree["parameters/chase/blend_position"] = _direction

func set_up_chase(_value):
	animation_tree["parameters/conditions/chase"] = _value
	animation_tree["parameters/conditions/attack"] = not _value

func set_up_attack(_value):
	animation_tree["parameters/conditions/attack"] = _value
	animation_tree["parameters/conditions/chase"] = not _value
