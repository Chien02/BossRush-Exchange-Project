extends Node2D

class_name Animation_Control
@export var state_machine : StateMachine
@export var animation_tree : AnimationTree
var tranformation : bool = false

func update_paramater_animation(direction):
	get_state()
	get_direction(direction)


func get_state():
	var _state_name = state_machine.current_state._name
	
	if (_state_name == "idle"): set_up_idle(true)
	elif (_state_name == "run"): set_up_walk(true)
	elif (_state_name == "dash"): set_up_dash(true)
	elif (_state_name == "hurt"): set_up_hurt(true)
	elif (_state_name == "attack"): set_up_attack(true)
	elif (_state_name == "ek_transform"): set_up_ek_transform(true)
	elif (_state_name == "ek_deform"): set_up_ek_deform(true)
	elif (_state_name == "ek_idle"): set_up_ek_idle(true)
	elif (_state_name == "ek_run"): set_up_ek_run(true)
	elif (_state_name == "ek_dash"): set_up_ek_dash(true)
	elif (_state_name == "ek_hurt"): set_up_ek_hurt(true)
	elif (_state_name == "ek_attack"): set_up_ek_attack(true)
	print("State: ", _state_name)

func get_direction(direction):
	if (direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Dash/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
		animation_tree["parameters/Hurt/blend_position"] = direction
		animation_tree["parameters/ek_idle/blend_position"] = direction
		animation_tree["parameters/ek_run/blend_position"] = direction
		animation_tree["parameters/ek_dash/blend_position"] = direction
		animation_tree["parameters/ek_hurt/blend_position"] = direction
	

func set_up_idle(value):
	animation_tree["parameters/conditions/idle"] = value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/hurt"] = not value
	animation_tree["parameters/conditions/dash"] = not value
	animation_tree["parameters/conditions/attack"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/exit_ek"] = not value

func set_up_hurt(value):
	animation_tree["parameters/conditions/hurt"] = value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/dash"] = not value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/attack"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value

func set_up_walk(value):
	animation_tree["parameters/conditions/is_moving"] = value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/dash"] = not value
	animation_tree["parameters/conditions/hurt"] = not value
	animation_tree["parameters/conditions/attack"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/exit_ek"] = not value

func set_up_dash(value):
	animation_tree["parameters/conditions/dash"] = value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/hurt"] = not value
	animation_tree["parameters/conditions/attack"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/exit_ek"] = not value

func set_up_attack(value):
	animation_tree["parameters/conditions/attack"] = value
	animation_tree["parameters/conditions/dash"] = not value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/hurt"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/exit_ek"] = not value

# Ek mode section
func set_up_ek_transform(value):
	animation_tree["parameters/conditions/ek_mode"] = value
	animation_tree["parameters/conditions/ek_attack"] = not value
	animation_tree["parameters/conditions/ek_dash"] = not value
	animation_tree["parameters/conditions/ek_run"] = not value
	animation_tree["parameters/conditions/ek_idle"] = value
	animation_tree["parameters/conditions/ek_hurt"] = not value
	animation_tree["parameters/conditions/exit_ek"] = not value

func set_up_ek_deform(value):
	animation_tree["parameters/conditions/exit_ek"] = value
	
	animation_tree["parameters/conditions/attack"] = not value
	animation_tree["parameters/conditions/dash"] = not value
	animation_tree["parameters/conditions/is_moving"] = not value
	animation_tree["parameters/conditions/idle"] = not value
	animation_tree["parameters/conditions/hurt"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/ek_attack"] = not value
	animation_tree["parameters/conditions/ek_dash"] = not value
	animation_tree["parameters/conditions/ek_run"] = not value
	animation_tree["parameters/conditions/ek_idle"] = not value
	animation_tree["parameters/conditions/ek_hurt"] = not value

func set_up_ek_idle(value):
	animation_tree["parameters/conditions/exit_ek"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/ek_attack"] = not value
	animation_tree["parameters/conditions/ek_dash"] = not value
	animation_tree["parameters/conditions/ek_run"] = not value
	animation_tree["parameters/conditions/ek_idle"] = value
	animation_tree["parameters/conditions/ek_hurt"] = not value

func set_up_ek_run(value):
	animation_tree["parameters/conditions/exit_ek"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/ek_attack"] = not value
	animation_tree["parameters/conditions/ek_dash"] = not value
	animation_tree["parameters/conditions/ek_run"] = value
	animation_tree["parameters/conditions/ek_idle"] = not value
	animation_tree["parameters/conditions/ek_hurt"] = not value
	
	animation_tree["parameters/conditions/dash"] = not value

func set_up_ek_dash(value):
	animation_tree["parameters/conditions/exit_ek"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/ek_attack"] = not value
	animation_tree["parameters/conditions/ek_dash"] = value
	animation_tree["parameters/conditions/ek_run"] = not value
	animation_tree["parameters/conditions/ek_idle"] = not value
	animation_tree["parameters/conditions/ek_hurt"] = not value

func set_up_ek_attack(value):
	animation_tree["parameters/conditions/exit_ek"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/ek_attack"] = value
	animation_tree["parameters/conditions/ek_dash"] = not value
	animation_tree["parameters/conditions/ek_run"] = not value
	animation_tree["parameters/conditions/ek_idle"] = not value
	animation_tree["parameters/conditions/ek_hurt"] = not value

func set_up_ek_hurt(value):
	animation_tree["parameters/conditions/exit_ek"] = not value
	animation_tree["parameters/conditions/ek_mode"] = not value
	animation_tree["parameters/conditions/ek_attack"] = not value
	animation_tree["parameters/conditions/ek_dash"] = not value
	animation_tree["parameters/conditions/ek_run"] = not value
	animation_tree["parameters/conditions/ek_idle"] = not value
	animation_tree["parameters/conditions/ek_hurt"] = value
