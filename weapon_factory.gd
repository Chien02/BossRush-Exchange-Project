extends Node2D

class_name Weapon_factory

var weapons = {
	"light_sword" : null,
	"Tree_hammer" : null,
	"Key" : null
}

func get_weapon(name: String):
	return weapons[name]
