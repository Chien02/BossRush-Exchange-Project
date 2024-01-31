extends CharacterBody2D

@export var SPEED := 70
@export var animation_control : Node2D
var damage := 50
var chase : bool = false
var attack : bool = false
var direction : Vector2 = Vector2.ZERO
var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	animation_control.update_paramater_animation(direction)

func _on_area_2d_body_entered(body):
	if (body.is_in_group("Player")):
		attack = true
		chase = false

func _on_area_2d_body_exited(body):
	if (body.is_in_group("Player")):
		attack = false
		chase = true

func _on_hurtbox_area_entered(_area):
	if (_area.is_in_group("Player") or _area.is_in_group("Weapon")):
		var tween = create_tween()
		tween.tween_property($".", "scale", Vector2(1, 1) * 0.6, 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
		tween.tween_property($".", "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
		Global.camera.shake(0.1, 3)

func _on_enemy_health_dead():
	#play dead animation before queue_free()
	queue_free()
