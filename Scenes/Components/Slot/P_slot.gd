extends Slot
 # player bag
var name_group = "Player"

func _ready():
	slot_sprite = $Slot
	icon_sprite = $Icon
	get_weapon(name_group)
	set_icon()


func _process(_delta):
	get_weapon(name_group)
	print("Player's weapon: ", weapon)
	if (weapon == null): return
	set_icon()

func set_icon():
	if weapon:
		icon_sprite.texture = weapon.icon

func active_icon(value: bool):
	slot_sprite.visible = value
	icon_sprite.visible = value

func discard(old):
	if (old):
		old.queue_free()

func add(new):
	var cb := func():
		var new_weapon = Weapons.get_weapon(new.name)
		add_child(new_weapon)
		weapon = new_weapon
	cb.call_deferred()

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
