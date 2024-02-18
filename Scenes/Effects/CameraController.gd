extends Node2D

class_name CameraController

@export var main_camera : Camera2D
@export var player : CharacterBody2D
@export var distance_out : float = 300
@export var distance_in : float = 300
@export var dead_zone : float = 60

var semi_camera
var out_focus : bool = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	#main_camera.enabled = true
	zoom_focus()

func zoom_focus():
	if (player.target):
		var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		var target_position = (player.target.global_position - player.global_position)
		if (target_position.length() < dead_zone):
			tween.parallel().tween_property(main_camera, "zoom", Vector2(2.5, 2.5), 0.5)
			tween.tween_property(main_camera, "position", Vector2.ZERO, 0.5)
		elif (target_position.length() > dead_zone and target_position.length() < distance_out):
			tween.parallel().tween_property(main_camera, "zoom", Vector2(2, 2), 0.5)
			tween.tween_property(main_camera, "position", target_position.normalized() * (target_position.length() - dead_zone) * 0.5, 0.5)
		elif (target_position.length() > distance_out):
			tween.parallel().tween_property(main_camera, "zoom", Vector2(2.5, 2.5), 0.3)
			tween.tween_property(main_camera, "position", Vector2.ZERO, 0.5)
	else:
		var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.parallel().tween_property(main_camera, "zoom", Vector2(2.5, 2.5), 0.1)
		tween.tween_property(main_camera, "position", Vector2.ZERO, 0.1)
