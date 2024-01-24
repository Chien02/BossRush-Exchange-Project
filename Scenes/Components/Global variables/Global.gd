extends Node

var camera : Camera2D
var tween : Tween

func get_tween():
	tween = get_tree().create_tween()
	return tween
