extends Node2D

class_name Animation_Control
@export var state_machine : StateMachine
@export var animation_tree : AnimationTree

func update_paramater_animation(direction):
	get_state()
	get_direction(direction)


func get_state():
	var _state_name = state_machine.current_state._name
	if (_state_name == "idle"): set_up_idle(true)
	elif (_state_name == "run"): set_up_walk(true)
	elif (_state_name == "dash"): set_up_dash(true)
	elif (_state_name == "attack"): set_up_attack(true)


func get_direction(direction):
	if (state_machine.current_state._name == "attack"):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Dash/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
	elif (direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Dash/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
		animation_tree["parameters/Attack/blend_position"] = direction

func get_atk_direction(direction):
	animation_tree["parameters/Attack/blend_position"] = direction
	
func set_up_idle(value):
	animation_tree["parameters/conditions/idle"] = value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/is_attacking"] = not value
	animation_tree["parameters/conditions/dash"] = not value
	

func set_up_walk(value):
	animation_tree["parameters/conditions/is_moving"] = value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/is_attacking"] = not value
	animation_tree["parameters/conditions/dash"] = not value

func set_up_dash(value):
	animation_tree["parameters/conditions/dash"] = value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/is_attacking"] = not value

func set_up_attack(value):
	animation_tree["parameters/conditions/is_attacking"] = value
	animation_tree["parameters/conditions/dash"] = not value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/idle"] = not value


