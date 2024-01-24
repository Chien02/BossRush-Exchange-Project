extends Node

var camera : Camera2D
var tween : Tween
var bag : Slot

func get_tween():
	tween = get_tree().create_tween()
	return tween
