extends Slot
 # player bag
var name_group = "Player"
func _ready():
	get_weapon(name_group)


func _process(_delta):
	get_weapon(name_group)
