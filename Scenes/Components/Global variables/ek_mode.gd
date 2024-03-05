extends Node2D

class_name Ek

@export var player : CharacterBody2D
@onready var ek_zone = $Ek_zone/CollisionShape2D
@onready var animator = $AnimationPlayer
@export var bonus_time : float = 12
var tranformation_finished : bool
var deformation_fisnished : bool
var ek_mode : bool = false
var can_ek : bool = false
var target
var player_wpn : String
var target_wpn : String
var success : bool = false
var anim_flag = false
var slow_effect : bool = false

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
	ek_chane()
	if (slow_effect):
		var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(Engine, "time_scale", 1, 0.5)
		await tween.finished
		slow_effect = false

func check_ek():
	can_ek = true if Global.player_energy.energy >= 3 else false
	return can_ek

func out_ek_mode():
	Global.player_energy.over_energy()
	can_ek = false
	ek_mode = false
	anim_flag = false
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
		success = true
		target = area.owner
		$Timer.wait_time = bonus_time
		$Timer.start()
		ek_effect(area.global_position)
		print("Success")

func switch_weapon():
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

func ek_chane():
	if (ek_mode):
		# Visible weapon slot
		player.bag.active_icon(ek_mode)
		if (player.target):
			player.target.bag.active_icon(ek_mode)
		if (success):
			Global.player_energy.change_success()
	else:
		player.bag.active_icon(ek_mode)
		if (player.target):
			player.target.bag.active_icon(ek_mode)

func _on_timer_timeout():
	out_ek_mode()

func rotate_ek_zone(value):
	ek_zone.rotation = value

func ek_zone_on():
	ek_zone.disabled = false

func ek_zone_off():
	ek_zone.disabled = true

func ek_effect(_position):
	$"Lightning Fx".global_position = _position
	$"Lightning Fx".visible = true
	animator.play("lightning")

func switch_screen_appear():
	var b_wpn
	var p_wpn = player.bag.icon_sprite.texture
	if (target): b_wpn = target.bag.icon_sprite.texture
	$CanvasLayer/Control/P_wpn.texture = p_wpn
	$CanvasLayer/Control/B_wpn.texture = b_wpn
	animator.play("switch")

func shake():
	Global.camera.shake(0.3, 5)
	
func shake2():
	Global.camera.shake(0.2, 5)

func slow_mo():
	Engine.time_scale = 0.1

func normal_mo():
	Engine.time_scale = 1

func paused_game():
	get_tree().paused = !get_tree().paused

func slow_after_switch():
	slow_effect = true
	Engine.time_scale = 0.5

func make_target_anger():
	if (!target): return
	target.be_eked = true
