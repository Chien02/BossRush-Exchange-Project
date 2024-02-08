extends Slot
 # boss bag
var name_group = "Boss"
func _ready():
	get_weapon(name_group)


func _process(_delta):
	get_weapon(name_group)
