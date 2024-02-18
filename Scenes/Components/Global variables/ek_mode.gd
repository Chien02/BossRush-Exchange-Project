extends Node2D

class_name Ek

@export var player : CharacterBody2D
@export var ek_mode : bool = false

var tranformation_finished : bool
var deformation_fisnished : bool
var can_ek : bool = true
var enemy

var player_wpn
var enemy_wpn

func _ready():
	Global.player_ek_mode = self
	if (player): enemy = player.target

func _process(_delta):
	if (player): enemy = player.target
	
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
		#$Ek_zone.visible = true
		#player.bag.active_icon(true)
		#if (enemy):
			#enemy.bag.active_icon(true)
	else:
		player.get_node("Animation/Normal Mode").visible = true
		player.get_node("Animation/Ek Mode").visible = false
		#$Ek_zone.visible = false
		#player.bag.active_icon(false)
		#if (enemy):
			#enemy.bag.active_icon(false)


func _on_ek_zone_area_entered(area):
	if (area.owner.is_in_group("Enemy")):
		ek_chane()

func ek_chane():
	if (!can_ek): return
	player_wpn = player.bag.weapon
	if (enemy):
		enemy_wpn = enemy.bag.weapon
	if (!player_wpn or !enemy_wpn):
		print("Error, cannot change")
		return
	$Ek_zone/CollisionShape2D.disabled = true
	#player.bag.discard(player_wpn)
	#enemy.bag.discard(enemy_wpn)
	#player.bag.add(enemy_wpn)
	#enemy.bag.add(player_wpn)
	#
	#await get_tree().create_timer(0.2).timeout
	#can_ek = false
	#$Ek_zone/CollisionShape2D.disabled = !can_ek
