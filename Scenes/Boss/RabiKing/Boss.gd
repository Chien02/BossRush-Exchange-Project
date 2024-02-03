extends CharacterBody2D
class_name Boss

@export var animation_control : Node2D
@export var distance : float

const SPEED = 45.0
var player : CharacterBody2D
var last_velocity = Vector2.ZERO
var direction := Vector2.ZERO
var damage : int = 30
var attack : bool = false
var sweep : bool = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	handle_velocity()
	animation_control.update_paramater_animation(direction)

func handle_velocity():
	if velocity != Vector2.ZERO:
		last_velocity = velocity

func _on_detect_player_zone_area_entered(area):
	if (area.owner.is_in_group("Player")):
		sweep = true
		velocity = Vector2.ZERO

func _on_detect_player_zone_area_exited(area):
	if (area.owner.is_in_group("Player")):
		sweep= false
