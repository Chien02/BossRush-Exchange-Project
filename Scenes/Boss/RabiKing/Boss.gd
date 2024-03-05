extends CharacterBody2D
class_name Boss

@export var state_machine : Node2D
@export var animation_control : Node2D
@export var distance : float
@export var damage : int = 30
@export var bag : Node2D

const SPEED = 45.0
var target : CharacterBody2D
var last_velocity = Vector2.ZERO
var direction := Vector2.ZERO
var attack : bool = false
var sweep : bool = false
var be_eked : bool = false

func _ready():
	target = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	handle_velocity()
	check_to_atk()
	animation_control.update_paramater_animation(direction)

func handle_velocity():
	if velocity != Vector2.ZERO:
		last_velocity = velocity

func check_to_atk():
	if (bag.weapon == null): return
	if (bag.weapon.can_attack):
		attack = true

func _on_sweep_zone_area_entered(area):
	if (area.owner.is_in_group("Player")):
		sweep = true
		velocity = Vector2.ZERO

func _on_sweep_zone_area_exited(area):
	if (area.owner.is_in_group("Player")):
		sweep = false
