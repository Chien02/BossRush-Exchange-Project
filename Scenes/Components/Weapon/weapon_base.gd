extends Node2D

class_name Weapon_base

# weapon properties
@export var wpn_name : String
@export var damage : int
@export var mana: int
@export var can_attack : bool = false
@export var hitbox : Area2D

var is_player : bool = false
var direction : Vector2
var animation_tree : AnimationTree
var icon
var cancel : bool = false

func hit():
	pass

func end_hit():
	pass

func set_attack(_value):
	pass

func play_animation(): # use in attack_state
	pass

func skill():
	pass

func is_not_use():
	pass

func animation(_input: bool, _is_player: bool):
	pass

func set_direction(_target, _is_player: bool):
	pass
