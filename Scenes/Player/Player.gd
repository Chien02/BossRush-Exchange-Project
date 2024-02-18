extends CharacterBody2D

class_name Player

@export var state_machine : Node2D
@export var animation_control : Node2D
@export var direction : Vector2 = Vector2.ZERO
@export var block_direction : bool = false # khi dash hoặc attack thì ko được chuyển hướng
@export var EK_SPEED := 125
@export var SPEED := 100
@export var ACCELERATION := 300
@export var FRICTION := 500
@export var maxHealth = 100
@export var bag : Node2D
var is_ek_change : bool
var world # use for aim system
var target # use for camear focus

func _ready():
	world = get_parent()

func _process(_delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	print("Player's weapon: ", bag.weapon.name)
	check_ek_change()
	
func _physics_process(delta):
	movement(delta)
	animation_control.update_paramater_animation(direction)
	
func movement(delta):
	# This variable is used for calculate velocity
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)# Acceleration
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) # Deceleration	move_and_slide() # Moving
	move_and_slide()

func check_ek_change():
	if (Input.is_action_just_pressed("ek")):
		is_ek_change = true
	handle_ek()


func handle_ek():
	if (is_ek_change):
		SPEED = EK_SPEED
		bag.weapon.process_mode = PROCESS_MODE_DISABLED
	else:
		SPEED = 100
		bag.weapon.process_mode = PROCESS_MODE_INHERIT
