extends Node2D

@export var state_machine : StateMachine
@export var animation_tree : AnimationTree

func update_paramater_animation(direction):
	get_state()
	get_direction(direction)

func get_state():
	var _state_name = state_machine.current_state._name
	if (_state_name == "boss_idle"): set_up_idle(true)
	elif (_state_name == "boss_chase"): set_up_chase(true)
	elif (_state_name == "boss_sweep"): set_up_sweep(true)
	elif (_state_name == "boss_hurt"): set_up_hurt(true)
	elif (_state_name == "boss_attack"): set_up_atk(true)

func get_direction(_direction):
	if (_direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = _direction
		animation_tree["parameters/chase/blend_position"] = _direction

func set_up_hurt(_value):
	pass

func set_up_atk(_value):
	animation_tree["parameters/conditions/attack"] = _value
	animation_tree["parameters/conditions/sweep"] = not _value
	animation_tree["parameters/conditions/idle"] = not _value
	animation_tree["parameters/conditions/chase"] = not _value
	animation_tree["parameters/conditions/cancel"] = not _value

func set_up_sweep(_value):
	animation_tree["parameters/conditions/sweep"] = _value
	animation_tree["parameters/conditions/idle"] = not _value
	animation_tree["parameters/conditions/chase"] = not _value
	animation_tree["parameters/conditions/attack"] = not _value
	animation_tree["parameters/conditions/cancel"] = not _value

func set_up_chase(_value):
	animation_tree["parameters/conditions/chase"] = _value
	animation_tree["parameters/conditions/cancel"] = not _value
	animation_tree["parameters/conditions/idle"] = not _value
	animation_tree["parameters/conditions/sweep"] = not _value
	animation_tree["parameters/conditions/attack"] = not _value

func set_up_idle(_value):
	animation_tree["parameters/conditions/idle"] = _value
	animation_tree["parameters/conditions/cancel"] = _value
	animation_tree["parameters/conditions/chase"] = not _value
	animation_tree["parameters/conditions/sweep"] = not _value
	animation_tree["parameters/conditions/attack"] = not _value
