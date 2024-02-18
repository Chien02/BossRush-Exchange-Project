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
	set_icon()

func set_icon():
	if weapon:
		icon_sprite.texture = weapon.icon

func active_icon(value: bool):
	slot_sprite.visible = value
	icon_sprite.visible = value

func discard(old):
	if (owner.state_machine.current_state.name == "attack"):
		owner.state_machine.current_state.attacking = false
	remove_child(old)

func add(new):
	var cb := func():
		var new_weapon = Weapons.get_weapon(new.name)
		add_child(new_weapon)
	cb.call_deferred()
