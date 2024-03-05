extends Weapon_base
# Tree hammer

@export var p_damage : int
@export var b_damage : int
@export var p_time : float = 0.75 # use for set timer in attack state
@export var b_time : float = 1.35 # use for set timer in attack state

var anim_tree
var atk_zone
var collision : CollisionShape2D
var anim_sprite
var anim_player
var is_playing : bool = false

func _ready():
	wpn_name = "TreeHammer"
	icon = preload("res://Sprites/Weapons/Tree_hammer_icon.png")
	initialize()

func hit():
	collision.disabled = false
	
func end_hit():
	if (collision):
		collision.disabled = true
	cancel = true
	can_attack = false
	animation_tree["parameters/conditions/can_attack"] = false
	animation_tree["parameters/conditions/cancel"] = true

func rotate_to_target(_target_pos, _is_player: bool):
	var delta = 0.75
	var angle_2
	var rotation_speed = 5
	
	if (!_is_player): # is_boss
		self.direction = Vector2.ZERO
		$Boss/Effect/ShadowHint.position = _target_pos
		collision.position = _target_pos
	else:
		self.direction = (_target_pos - hitbox.position).normalized()
		angle_2 = hitbox.transform.x.angle_to(self.direction)
		hitbox.rotate(sign(angle_2) * min(delta * rotation_speed, abs(angle_2)))
	return self.direction

func animation(_input: bool, _is_player: bool):
	animation_tree = $AnimationTree
	atk_zone = $Boss/Atk_zone
	animation_tree["parameters/conditions/can_attack"] = true
	animation_tree["parameters/conditions/cancel"] = false
	animation_tree["parameters/conditions/is_player"] = _is_player
	animation_tree["parameters/conditions/attack"] = true
	animation_tree["parameters/conditions/is_boss"] = !_is_player
	anim_sprite = get_node("Player/PlayerAnimated") if _is_player else get_node("Boss/BossAnimated")
	hitbox = get_node("Player/Hitbox") if _is_player else get_node("Boss/Hitbox")
	collision = get_node("Player/Hitbox/Phitbox") if _is_player else get_node("Boss/Hitbox/Bhitbox")
	atk_zone.get_child(0).disabled = false if (!_is_player) else true
	anim_sprite.visible = true
	collision.visible = true

func set_direction(_target, _is_player):
	if (_is_player):
		animation_tree["parameters/player/blend_position"] = rotate_to_target(_target, _is_player)
	else:
		animation_tree["parameters/boss/blend_position"] = rotate_to_target(_target, _is_player)
	
# For input: boss
func _on_atk_zone_area_entered(area):
	if area.owner.is_in_group("Player"):
		can_attack = true
		cancel = false

# For input: player
func check_player_input():
	if (Input.is_action_just_pressed("attack")):
		can_attack = true
		cancel = false

func initialize():
	animation_tree = $AnimationTree
	is_player = true if get_parent().get_parent().is_in_group("Player") else false
	collision = get_node("Player/Hitbox/Phitbox") if is_player else get_node("Boss/Hitbox/Bhitbox")
	animation_tree["parameters/conditions/is_player"] = is_player
	animation_tree["parameters/conditions/is_boss"] = !is_player
	animation_tree["parameters/conditions/can_attack"] = false
	animation_tree["parameters/conditions/cancel"] = true
	animation_tree["parameters/conditions/attack"] = false
	anim_sprite = get_node("Player/PlayerAnimated") if is_player else get_node("Boss/BossAnimated")
	damage = p_damage if is_player else b_damage
	hitbox = get_node("Player/Hitbox") if is_player else get_node("Boss/Hitbox")
	can_attack = false
	cancel = true
