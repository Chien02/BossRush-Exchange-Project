extends Node2D

class_name Ek

@export var player : CharacterBody2D
var can_ek : bool = false
@export var ek_mode : bool = false
var tranformation_finished : bool
var deformation_fisnished : bool

func _ready():
	Global.player_ek_mode = self

func _process(_delta):
	if (check_ek() and Input.is_action_just_pressed("ek")):
		ek_mode = true
		print("Change to Ek mode")
	check_to_change()

func check_ek():
	can_ek = true if Global.player_energy.energy >= 3 else false
	return can_ek

func out_ek_mode():
	can_ek = false
	ek_mode = false

func check_to_change():
	if (ek_mode):
		player.get_node("Animation/Normal Mode").visible = false
		player.get_node("Animation/Ek Mode").visible = true
	else:
		player.get_node("Animation/Normal Mode").visible = true
		player.get_node("Animation/Ek Mode").visible = false
