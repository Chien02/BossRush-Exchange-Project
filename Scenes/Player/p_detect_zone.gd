extends Area2D

@export var player : CharacterBody2D
var list = []
var target

signal new_target(_target)

func _process(_delta):
	if (check_list() == false): return
	if (list.size() > 1):
		var _min = abs(player.global_position - list[0].global_position)
		for enemy in list:
			var distance = abs(player.global_position - enemy.global_position)
			if (_min > distance):
				_min = distance
				target = enemy
				list.erase(enemy)
	elif (list.size() == 1):
		target = list.pop_back()
	
	if (target):
		new_target.emit(target)

func check_list():
	for enemy in list:
		if !enemy:
			return false
	return true

func _on_area_entered(area):
	if (area.is_in_group("Enemy")):
		list.append(area.owner)
