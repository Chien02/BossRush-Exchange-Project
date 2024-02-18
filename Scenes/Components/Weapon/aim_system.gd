extends Node2D

class_name AimSystem

@export var root_node : Node2D
@export var distance : float
@export var active : bool = false

var can_switch : bool = false
var last_child_count : int = 0
var last_min_dis : float = 0
var min_dis : float = 0
var last_temp_list = []
var temp_list = []
var flag : bool = false
var has_ring : bool = false
var list = []
var target : CharacterBody2D
var user

func _ready():
	user = get_parent()
	active = false
	target = null
	visible = false

func _process(_delta):
	# test
	#add_enemy()
	#if (Input.is_action_just_pressed("dash")):
		#$"../Enemy".queue_free()
	# test
	if (!root_node):
		root_node = get_parent().world
	control_aim()
	visible = active
	if (active == false):
		return
	check_amount()
	get_target_list()
	update_list()
	sort_list()
	set_target()
	check_to_change()
	rotate_to_target()

func check_amount():
	if (root_node.get_child_count() > last_child_count):
		last_child_count = root_node.get_child_count()
		flag = false

func add_enemy():
	if (Input.is_action_just_pressed("ek")):
		var enemy = preload("res://Scenes/enemy_v2/enemy_v2.tscn").instantiate()
		root_node.add_child(enemy)

func control_aim():
	if (Input.is_action_just_pressed("aim")):
		if (!active):
			active = true


	if (Input.is_action_just_pressed("exit_aim")):
		active = exit_aim()

func sort_list():
	if (list.size() < 2): return
	list.sort_custom(sort_distance)
	
func sort_distance(a, b):
	var temp_a = a.global_position - user.global_position
	var temp_b = b.global_position - user.global_position
	if (temp_a < temp_b):
		return true
	else:
		return false

func update_list():
	for enemy in list:
		if (enemy == null):
			list.erase(enemy)
			flag = false
	get_target_list()

func get_target_list():
	temp_list = get_tree().get_nodes_in_group("Enemy")
	if (temp_list.size() != last_temp_list.size()):
		last_temp_list = temp_list
		flag = false
	var index : int = 0
	while (flag == false):
		if (temp_list[index] is CharacterBody2D and list.find(temp_list[index]) == -1):
			list.append(temp_list[index])
		index += 1
		if (index == temp_list.size()):
			flag = true

func set_target():
	if (list.size() < 1): return
	if (!target):
		target = list[0]
		has_ring = false
	else:
		can_switch = true
		target.get_node("Target_ring").visible = true
		if (!has_ring):
			has_ring = true
			ring_animation()
	user.target = target

func get_target():
	if (target): return target

func check_to_change():
	if Input.is_action_just_pressed("aim"):
		change_target()

func change_target():
	if (list.size() >= 1 and can_switch):
		var idx = list.find(target)
		target.get_node("Target_ring").visible = false
		target = list[(idx + 1) % list.size()]
		can_switch = false

func exit_aim():
	if (active == true):
		if (target):
			target.get_node("Target_ring").visible = false
			target = null
			user.target = null
	return false

func ring_animation():
	var tween = create_tween()
	var ring = target.get_node("Target_ring")
	tween.tween_property(ring, "scale", Vector2(3, 2), 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(ring, "scale", Vector2(2.3, 1.3), 0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func rotate_to_target():
	var delta = 0.75
	var angle_2
	var rotation_speed = 5
	
	if (target):
		var direction = (target.global_position - user.global_position).normalized()
		angle_2 = $".".transform.x.angle_to(direction)
		$".".rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
