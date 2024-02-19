extends Slot
 # boss bag
var name_group = "Boss"
var has_changed : bool = false

func _ready():
	slot_sprite = $Slot
	icon_sprite = $Icon
	get_weapon(name_group)
	if (check_weapon() == false):
		return
	set_icon()

func _process(_delta):
	get_weapon(name_group)
	if (!weapon): return
	print("Boss's weapon: ", weapon)
	set_icon()

func set_icon():
	if weapon:
		icon_sprite.texture = weapon.icon

func active_icon(value: bool):
	slot_sprite.visible = value
	icon_sprite.visible = value

func discard(_old):
	if (_old):
		_old.queue_free()

func add(_new):
	var cb := func():
		var new_weapon = Weapons.get_weapon(_new.name)
		add_child(new_weapon)
		weapon = new_weapon
	cb.call_deferred()
