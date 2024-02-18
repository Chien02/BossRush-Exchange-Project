extends Slot
 # boss bag
var name_group = "Boss"
var has_changed : bool = false

func _ready():
	slot_sprite = $Slot
	icon_sprite = $Icon
	get_weapon(name_group)
	set_icon()


func _process(_delta):
	get_weapon(name_group)
	set_icon()

func set_icon():
	if weapon and !has_changed:
		has_changed = true
		icon_sprite.texture = weapon.icon

func active_icon(value: bool):
	slot_sprite.visible = value
	icon_sprite.visible = value

func discard(_old):
	if (owner.state_machine.current_state.name == "boss_attack"):
		owner.state_machine.current_state.attacking = false
	remove_child(_old)

func add(_new):
	var cb := func():
		var new_weapon = Weapons.get_weapon(_new.name)
		add_child(new_weapon)
		has_changed = false
	cb.call_deferred()
