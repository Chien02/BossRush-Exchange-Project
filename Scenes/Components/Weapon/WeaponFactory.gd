extends Node2D
class_name WeaponFactory

var weapons = {
	"lighting_sword" = preload("res://Scenes/Components/Weapon/lighting_sword.tscn"),
	"tree_hammer" = preload("res://Scenes/Components/Weapon/tree_hammer.tscn")
}

func get_weapon(_name: String):
	var weapon
	if (_name == "LightingSword"):
		weapon = weapons["lighting_sword"].instantiate()
	elif (_name == "TreeHammer"):
		weapon = weapons["tree_hammer"].instantiate()
	return weapon
