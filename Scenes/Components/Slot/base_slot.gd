extends Node2D
class_name Slot

@export var item : String
@export var weapon : Node2D

var slot_sprite : Sprite2D
var icon_sprite : Sprite2D

func _ready():
	pass

func _process(_delta):
	pass

# Function that receive other item and switch it to current item
# There are two cases: when character are not have any weapon yet
# and they have already.
# After switch, this function have to return the item its hold before switch

func display():
	if (item): print("Item: " + item)
	else: print("There don't have any item.")

func get_weapon(name_group : String):
	if (weapon): return
	if (get_child_count() <= 0): return
	var stuffs = get_children()
	for object in stuffs:
		if object.is_in_group("Weapon"):
			weapon = object
	
	# Add weapon to group
	if (weapon == null): return
	if (weapon.is_player):
		weapon.get_node(name_group).get_node("Hitbox").add_to_group(name_group)
	else:
		weapon.get_node(name_group).get_node("Hitbox").add_to_group(name_group)

func set_icon():
	pass

func active_icon(value: bool):
	slot_sprite.visible = value
	icon_sprite.visible = value

func discard(_old):
	pass

func add(_new):
	pass

func check_weapon():
	return weapon != null
