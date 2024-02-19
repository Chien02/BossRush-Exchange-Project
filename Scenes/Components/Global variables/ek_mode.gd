extends Node2D

class_name Ek

@export var player : CharacterBody2D

var tranformation_finished : bool
var deformation_fisnished : bool
var ek_mode : bool = false
var can_ek : bool = false
var target
var player_wpn : String
var target_wpn : String
var success : bool = false

func _ready():
	Global.player_ek_mode = self
	if (player): target = player.target

func _process(_delta):
	if (player): target = player.target
	
	if (check_ek() and Input.is_action_just_pressed("ek")):
		ek_mode = true
		print("Change to Ek mode")
	check_to_change()
	ek_chane()

func check_ek():
	can_ek = true if Global.player_energy.energy >= 3 else false
	return can_ek

func out_ek_mode():
	can_ek = false
	ek_mode = false

func check_to_change():
	if (ek_mode):
		if (!success): Global.player_energy.change_active()
		player.get_node("Animation/Normal Mode").visible = false
		player.get_node("Animation/Ek Mode").visible = true
	else:
		player.get_node("Animation/Normal Mode").visible = true
		player.get_node("Animation/Ek Mode").visible = false

func _on_ek_zone_area_entered(area):
	if (area.owner.is_in_group("Enemy")):
		change_mode()

func change_mode():
	if (!can_ek): return
	can_ek = false
	player_wpn = player.bag.weapon.wpn_name # Get player's weapon
	if (target): target_wpn = target.bag.weapon.wpn_name  # Get target's weapon
	if (!player_wpn or !target_wpn):
		print("Error, cannot change")
		return
	
	target.attack = false
	var new_p_wpn = Weapons.get_weapon(target_wpn)
	var new_b_wpn = Weapons.get_weapon(player_wpn)
	player.bag.add(new_p_wpn)
	target.bag.add(new_b_wpn)
	player.bag.discard(player.bag.weapon)
	target.bag.discard(target.bag.weapon)
	
	await get_tree().create_timer(0.2).timeout
	$Ek_zone/CollisionShape2D.disabled = true

func ek_chane():
	if (ek_mode):
		if Input.is_action_just_pressed("ek"):
			pass
			# Do the ek_chane move
			# If success
			#success = true
			#Global.player_energy.change_success()
