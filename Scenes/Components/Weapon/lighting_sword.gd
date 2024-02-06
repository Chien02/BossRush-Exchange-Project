extends Weapon_base

func _ready():
	# character -> state machine
	animation_tree = get_node("AnimationTree")
	get_character()
	rotate_to_target(target)
	state_machine = character.get_node("State Machine") 

func _process(_delta):
	get_character()
	if (state_machine.current_state._name != "attack"): # if player
		hitbox.disabled = true
	rotate_to_target(target)

func play_animation():
	if (!animation_tree): 
		print("Didn't see animation_tree")
		return
	# Set up condition
	
	animation_tree["parameters/conditions/is_player"] = check_user()
#		animation_tree["parameters/conditions/is_boss"] = check_user()
	# Set up direction for animation
	animation_tree["parameters/player/blend_position"] = rotate_to_target(target)
	#animation_tree["parameters/boss/blend_position"] = direction

func set_attack(value):
	animation_tree["parameters/conditions/can_attack"] = value
	animation_tree["parameters/conditions/cannot_attack"] = !value
	
func rotate_to_target(_target):
	var delta = 0.75
	var angle_2
	var rotation_speed = 5
	if (is_player == false):
		direction = character.direction
		angle_2 = $Hitbox.transform.x.angle_to(direction)
		$Hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
		return direction
	
	direction = (_target.global_position - $Hitbox.global_position).normalized()
	angle_2 = $Hitbox.transform.x.angle_to(direction)
	$Hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
	return direction
