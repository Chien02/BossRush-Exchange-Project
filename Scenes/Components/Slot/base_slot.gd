extends Node2D
class_name Slot

@export var item : String
@export var weapon : Node2D
@export var scale_rate : float = 0.05

@onready var main_weapon_sprite = $MainWeapon
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
	if (value):
		#main_weapon_sprite.visible = true
		var tween = get_tree().create_tween()
		$MainWeapon/Slot.rotation = -5
		$MainWeapon/Icon.rotation = -5
		tween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		tween.tween_property(main_weapon_sprite, "visible", value, 0.1)
		tween.tween_property(main_weapon_sprite, "scale", Vector2.ONE * scale_rate, 0.5)
		tween.parallel().tween_property($MainWeapon/Slot, "rotation", 0, 1)
		tween.parallel().tween_property($MainWeapon/Icon, "rotation", 0, 1)
		
	else:
		var tween = get_tree().create_tween()
		$MainWeapon/Slot.rotation = -5
		$MainWeapon/Icon.rotation = -5
		tween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		tween.tween_property(main_weapon_sprite, "scale", Vector2.ZERO, 1)
		tween.tween_property(main_weapon_sprite, "visible", value, 0.1)
		#await tween.finished
	

func discard(_old):
	pass

func add(_new):
	pass

func check_weapon():
	return weapon != null

func set_weapon_pos():
	if (weapon):
		weapon.global_position = get_parent().global_position
