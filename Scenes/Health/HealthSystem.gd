extends Node2D
class_name HealthSystem

@export var character : CharacterBody2D
@export var max_health := 100

var current_health
var is_hurting : bool = false
var death : bool = false
signal dead

func _ready():
	init_health()

func _process(delta):
	if current_health == 0:
		death = true

func init_health():
	current_health = max_health

func heal(value):
	current_health += value
	if (current_health > max_health):
		current_health = max_health

func hurt(value):
	is_hurting = true
	current_health -= value
	# For dead
	if (current_health <= 0):
		current_health = 0
		dead.emit()
		death = true

func knockback(opp_velocity, _knock_pwr):
	var knock_direction = (opp_velocity).normalized() * pow(_knock_pwr, 2)
	get_parent().velocity = knock_direction
	get_parent().move_and_slide()
