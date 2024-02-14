extends Node

var p_health : HealthSystem
var b_health : HealthSystem
var player : CharacterBody2D
var player_energy : Energy
var player_ek_mode : Ek
var player_dead : bool = false
var platform : bool = false # false = PC, true = mobile
var camera : Camera2D
var tween : Tween
var bag : Slot

func get_tween():
	tween = get_tree().create_tween()
	return tween

func zoom(duration):
	var last_zoom = Vector2.ZERO
	if (last_zoom == Vector2.ZERO):
		last_zoom = camera.zoom # get the last zoom, then use it when 
	camera.zoom += Vector2(0.05, 0.05)
	await get_tree().create_timer(duration, true, false, true).timeout
	camera.zoom = last_zoom

func frame_freeze(_time_scale, duration):
	Engine.time_scale = _time_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1
