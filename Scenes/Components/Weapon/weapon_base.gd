extends Node2D

class_name Weapon_base

@export var damage : int
@export var mana: int
@export var can_attack : bool = false
@export var hitbox : CollisionShape2D

var state_machine
var is_player : bool = false
var character
var target
var direction : Vector2
var animation_tree : AnimationTree

func _ready():
	hitbox.disabled = true
	get_character()

func _process(_delta):
	get_character()

func hit():
	hitbox.disabled = false

func end_hit():
	hitbox.disabled = true

func get_character():
	character = get_parent().get_parent()
	is_player = true if (character.is_in_group("Player")) else false
	if (is_player == false):
		target = get_tree().get_first_node_in_group("Player")
	else:
		target = get_tree().get_first_node_in_group("Boss")

func set_attack(_value):
	pass

func play_animation(): # use in attack_state
	pass

func check_user():
	return (is_player==true)

func skill():
	pass

func rotate_to_target(_target):
	pass

func is_not_use():
	return character==null # if not use then it can be collect if it were apeared on scenes
