extends Node2D

@export var damage : int = 30
@export var speed_attack: int
@export var mana: int
@export var skill: Node2D

@onready var animation_player = $AnimationPlayer

var attacked : bool = false

func hit(direction):
	if (attacked): return
	#animator["parameters/Slash/blend_position"] = direction
	#animator["parameters/conditions/slash"] = true
	#animator["parameters/conditions/not_slash"] = false
	if direction.angle() == 0:
		animation_player.play("slash_right")
	elif direction.angle() < 0:
		animation_player.play("slash_up")
	elif direction.angle() > 1 and direction.angle() < 3:
		animation_player.play("slash_down")
	else:
		animation_player.play("slash_left")
	attacked = true

func end_hit():
	attacked = false
	#animator["parameters/conditions/not_slash"] = true
	#animator["parameters/conditions/slash"] = false
