extends Node2D

class_name Ek

@export var player : CharacterBody2D
@onready var ek_zone = $Ek_zone/CollisionShape2D
var tranformation_finished : bool
var deformation_fisnished : bool
var ek_mode : bool = false
var can_ek : bool = false
var target
var player_wpn : String
var target_wpn : String
var success : bool = false
var anim_flag = false

func _ready():
	ek_mode = false
	Global.player_ek_mode = self
	if (player): target = player.target
	player.get_node("Animation/Normal Mode").visible = true
	player.get_node("Animation/Ek Mode").visible = false

func _process(_delta):
	if (player): target = player.target
	
	if (check_ek() and Input.is_action_just_pressed("ek")):
		if (!ek_mode):
			ek_mode = true
			player.bag.active_icon(ek_mode)
			$Timer.start()
			print("Change to Ek mode")
	ek_chane()

func check_ek():
	can_ek = true if Global.player_energy.energy >= 3 else false
	return can_ek

func out_ek_mode():
	Global.player_energy.over_energy()
	can_ek = false
	ek_mode = false
	player.bag.active_icon(ek_mode)
	if (player.target):
		player.target.bag.active_icon(ek_mode)

func turn_to_ek():
	if (!ek_mode): return
	if (!success): Global.player_energy.change_active()
	player.get_node("Animation/Normal Mode").visible = false
	player.get_node("Animation/Ek Mode").visible = true

func turn_to_normal():
	if ek_mode: return
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
		# Visible weapon slot
		player.bag.active_icon(ek_mode)
		ek_zone.disabled = !ek_mode
		if (player.target):
			player.target.bag.active_icon(ek_mode)
		if Input.is_action_just_pressed("ek"):
			pass
			# Do the ek_chane move
			# If success
			#success = true
			#Global.player_energy.change_success()
	else:
		player.bag.active_icon(ek_mode)
		ek_zone.disabled = !ek_mode
		if (player.target):
			player.target.bag.active_icon(ek_mode)
		

func _on_timer_timeout():
	out_ek_mode()
