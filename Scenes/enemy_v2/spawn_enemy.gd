extends Node2D

var list = []
var enemy = preload("res://Scenes/enemy_v2/enemy_v2.tscn")

func _ready():
	init_list(2)

func _process(_delta):
	check_list()

func init_list(value: int):
	for i in range(value):
		var new_enemy = enemy.instantiate()
		get_tree().current_scene.add_child.call_deferred(new_enemy)
		new_enemy.position = Vector2(randf_range(0, 100), randf_range(0, 100))
		list.append(new_enemy)

func check_list():
	for i in list:
		if (!i):
			list.erase(i)
	var count = list.size()
	if count < 2:
		init_list(2 - count)
