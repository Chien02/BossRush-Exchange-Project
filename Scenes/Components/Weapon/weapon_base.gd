extends Node2D

var target
@export var player : CharacterBody2D
@export var damage : int = 50
@export var speed_attack: int
@export var mana: int
@export var skill: Node2D
@export var can_attack : bool = true
@onready var hitbox = $Hitbox/CollisionShape2D

func _process(_delta):
	if (player.get_child(3).current_state._name != "attack"):
		hitbox.disabled = true
	rotate_to_target(target)

func hit():
	if (!can_attack): return
	hitbox.disabled = false

func end_hit():
	hitbox.disabled = true

func _on_p_detect_zone_new_target(_target):
	if (!_target):
		target = null
		return
	target = _target

func rotate_to_target(_target):
	var delta = 0.75
	var direction
	var angle_2
	var rotation_speed = 5
	if (!_target): 
		direction = player.direction
		angle_2 = $Hitbox.transform.x.angle_to(direction)
		$Hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
		return
	direction = (_target.global_position - $Hitbox.global_position).normalized()
	angle_2 = $Hitbox.transform.x.angle_to(direction)
	$Hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
	
