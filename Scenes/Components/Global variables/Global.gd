extends Node

var p_health : HealthSystem
var b_health : HealthSystem
var player_dead : bool = false
var camera : Camera2D
var tween : Tween
var bag : Slot

func get_tween():
	tween = get_tree().create_tween()
	return tween

func frame_freeze(_time_scale, duration):
	
	Engine.time_scale = _time_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1
