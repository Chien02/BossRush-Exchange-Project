extends Weapon_base
# Tree hammer
func _ready():
	# character -> state machine
	hitbox = get_node("Hitbox").get_child(0)
	animation_tree = get_node("AnimationTree")
	get_character()
	rotate_to_target(target)
	state_machine = character.get_node("State Machine")
	$Hitbox/Effect/ShadowHint.visible = false
	$Hitbox/Effect/Impact.visible = false

func _process(_delta):
	get_character()
	if (state_machine.current_state._name != "boss_attack"):
		hitbox.disabled = true

func skill():
	var effect_animator = $Hitbox/Effect/AnimationPlayer
	effect_animator.play("effect")
	$Hitbox/Effect/ShadowHint.visible = false
	$Hitbox/Effect/Impact.visible = true

func play_impact():
	$Hitbox/Effect/AnimationPlayer2.play("impact")
	Global.camera.shake(0.1, 5)
	
func end_hit():
	$Hitbox/Effect/Impact.visible = false
	hitbox.disabled = true
	
func scale_collision():
	create_tween().tween_property($Hitbox/Bhitbox, "scale", Vector2(1.2, 1.2), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

func play_animation():
	if (!animation_tree): 
		print("Didn't see animation_tree")
		return
	# Set up condition
	$Hitbox/Bhitbox.scale = Vector2(0.25, 0.25)
	$Hitbox/Effect/ShadowHint.visible = true
	animation_tree["parameters/conditions/is_player"] = check_user()
	animation_tree["parameters/conditions/is_boss"] = !check_user()
	# Set up direction for animation
	animation_tree["parameters/player/blend_position"] = rotate_to_target(target)
	animation_tree["parameters/boss/blend_position"] = rotate_to_target(target)

func set_attack(value):
	animation_tree["parameters/conditions/can_attack"] = value
	animation_tree["parameters/conditions/cannot_attack"] = !value

func rotate_to_target(_target):
	var delta = 0.75
	var angle_2
	var rotation_speed = 5
	
	if (is_player == false): # boss
		var _pos = _target.global_position
		$Hitbox/Effect.global_position = _pos
		$Hitbox/Bhitbox.global_position = _pos
		return direction
	else:
		if !_target: 
			direction = character.direction
			angle_2 = $Hitbox.transform.x.angle_to(direction)
			$Hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
			return direction
		
		direction = (_target.global_position - $Hitbox.global_position).normalized()
		angle_2 = $Hitbox.transform.x.angle_to(direction)
		$Hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
		return direction
