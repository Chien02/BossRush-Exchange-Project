extends Weapon_base
# Tree hammer

@export var p_animated : AnimatedSprite2D
@export var p_hitbox : Area2D
@export var p_damage : int
@export var b_animated : AnimatedSprite2D
@export var b_hitbox : Area2D
@export var b_damage : int
@export var animator : AnimationPlayer # This is the main AnimationPlayer
@export var effect : AnimatedSprite2D # Depends on who is it, if player then it will impact
@export var effect_animator : AnimationPlayer
@export var impact : AnimatedSprite2D # In boss node
@export var impact_animator : AnimationPlayer
@export var shadow_hint : Sprite2D # use for boss
@export var player : Node2D
@export var boss : Node2D
@export var using_time : float = 1.4

var user : String # To define who is using this
var is_playing : bool = false

func _ready():
	get_character() # check for who is using this weapon
	set_character() # set for the first time appear in tree
	set_using_time()
	state_machine = character.get_node("State Machine")
	animation_tree = $AnimationTree

func _process(_delta):
	if (is_user_changed()): # Update information if user changed
		get_character()
		set_character()
		set_using_time()
	set_hitbox() # This user for disable hitbox when not in attack state
	#rotate_to_target(target)

func set_character():
	var off_layer = 0b000 # collision layer 0
	var hitbox_layer = 0b010 # collision layer 2
	player.visible = check_user() # turn on or off visible depends on who is use this weapon
	p_animated.visible = false # The sprite appear on screen
	boss.visible = !check_user()
	b_animated.visible = false # The sprite appear on screen
	# 3 main variable
	user = "player" if (check_user()) else "boss"
	damage = p_damage if (check_user()) else b_damage
	hitbox = p_hitbox.get_child(0) if (check_user()) else b_hitbox.get_child(0)
	
	if (check_user()): # is player -> turn off boss's collsision, else reverse
		b_hitbox.collision_layer = off_layer
		p_hitbox.collision_layer = hitbox_layer
		effect = null
		effect_animator = null
		impact = $Player/Hitbox/Effect
		impact_animator = $"Player/Hitbox/Effect/Impact Animator"
	else:
		b_hitbox.collision_layer = hitbox_layer
		p_hitbox.collision_layer = off_layer
		effect = $Boss/Effect
		effect_animator = $"Boss/Effect/Effect Animator"
		impact = $Boss/Effect/Impact
		impact_animator = $"Boss/Effect/Impact Animator"


func set_hitbox():
	if (user == "player"):
		if (state_machine.current_state._name != "attack"):
			p_hitbox.get_child(0).disabled = true
		b_hitbox.get_child(0).disabled = true
	elif (user == "boss"):
		if (state_machine.current_state._name != "boss_attack"):
			b_hitbox.get_child(0).disabled = true
		p_hitbox.get_child(0).disabled = true

func set_using_time():
	using_time = 0.7 if (user == "player") else 1.4

func skill(): # This function is used to call in main Animation Player -> use for Effect
	effect_animator.play("effect")
	set_fx_visible(true)

func play_impact():# This function is used to call in main Animation Player -> use for Impact
	var p_pwr = 1.5
	var b_pwr = 2.5
	var duration = 0.1
	var shake_pwr = p_pwr if check_user() else b_pwr
	impact_animator.play("impact")
	if (Global.camera):
		Global.camera.shake(duration, shake_pwr)

func end_hit():
	if (user == "player"):
		p_hitbox.get_child(0).disabled = true
	else:
		b_hitbox.get_child(0).disabled = true
		$Boss/Effect/ShadowHint.visible = false
	is_playing = false
	
func scale_collision():
	var tween = create_tween()
	tween.tween_property(b_hitbox.get_child(0), "scale", Vector2(3, 3), 0.6).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(b_hitbox.get_child(0), "scale", Vector2(1, 1), 0.2).set_ease(Tween.EASE_OUT)
	
func play_animation():
	if (!animation_tree):
		print("Didn't see animation_tree")
		return
	# Turn on visible for what is playing animation
	if (check_user()):
		p_animated.visible = true
	else:
		b_animated.visible = true
		$Boss/Effect/ShadowHint.visible = false
	# Set up condition
	b_hitbox.scale = Vector2(0.25, 0.25)
	# Reset direction
	animation_tree["parameters/conditions/is_player"] = check_user()
	animation_tree["parameters/conditions/is_boss"] = !check_user()
	# Set up direction for animation
	if (character.direction != Vector2.ZERO):
		animation_tree["parameters/player/blend_position"] = character.direction
		animation_tree["parameters/boss/blend_position"] = rotate_to_target(target)
	

func set_attack(_value):
	if (animation_tree):
		animation_tree["parameters/conditions/can_attack"] = _value
		animation_tree["parameters/conditions/cannot_attack"] = !_value
		
func rotate_to_target(_target):
	var delta = 0.75
	var angle_2
	var rotation_speed = 5
	
	if (is_player == false): # is_boss
		var _pos = _target.global_position
		effect.global_position = _pos
		b_hitbox.get_child(0).global_position = _pos
		return direction
	
	if (is_player == true):
		if !_target: # didn't find any target
				direction = character.direction
				angle_2 = p_hitbox.transform.x.angle_to(character.direction)
				p_hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
				return direction
		else: # found target
			direction = (_target.global_position - p_hitbox.global_position).normalized()
			angle_2 = p_hitbox.transform.x.angle_to(direction)
			p_hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
			return direction

func set_fx_visible(value: bool):
	shadow_hint.visible = value
	effect.visible = value

func is_user_changed():
	if (check_user() and user != "player"):
		return true
	else:
		return false
