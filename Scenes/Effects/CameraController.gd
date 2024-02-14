extends Node2D

class_name CameraController

@export var main_camera : Camera2D
@export var player : CharacterBody2D
@export var distance_out : float = 3.0
@export var distance_in : float = 1.75
var semi_camera
var out_focus : bool = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	if (player.target):
		semi_camera = player.target.get_node("Camera2D")
	if (player.target and !out_focus):
		main_camera.enabled = false
		semi_camera.enabled = true
	elif (player.target and out_focus):
		semi_camera.enabled = false
		main_camera.enabled = true
	zoom_focus()

func zoom_focus():
	if (!player.target): return
	var tween = get_tree().create_tween()
	var semi_camera = player.target.get_node("Camera2D")
	var distance = player.position.distance_to(player.target.position) / 100.0
	if (distance > distance_in and distance <= distance_out):
		out_focus = false
		tween.tween_property(semi_camera, "zoom", Vector2(1.5, 1.5), 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	elif (distance <= distance_in):
		out_focus = false
		tween.tween_property(semi_camera, "zoom", Vector2(2.3, 2.3), 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	elif (distance > distance_out):
		out_focus = true
		tween.stop()
