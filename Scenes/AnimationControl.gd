extends Node2D

class_name Animation_Control

@onready var animation_tree : AnimationTree = $"../AnimationTree"

func update_paramater_animation(direction):
	var walk = true if (direction != Vector2.ZERO) else false
	var dash = true if (Input.is_action_just_pressed("ui_accept")) else false
	var attack = true if (Input.is_action_just_pressed("ui_cancel")) else false
	set_up_walk(walk)
	set_up_dash(dash)
	set_up_attack(attack)
	get_direction(direction)

func get_direction(direction):
	if (direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/Attack/blend_position"] = direction
		animation_tree["parameters/Dash/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction

func set_up_walk(value):
	animation_tree["parameters/conditions/is_moving"] = value
	animation_tree["parameters/conditions/idle"] = not value

func set_up_dash(value):
	animation_tree["parameters/conditions/dash"] = value

func set_up_attack(value):
	animation_tree["parameters/conditions/is_attacking"] = value