extends CharacterBody2D

class_name Player

@export var animation_control : Node2D
@export var direction : Vector2 = Vector2.ZERO
@export var block_direction : bool = false # khi dash hoặc attack thì ko được chuyển hướng
@export var SPEED := 100
@export var ACCELERATION := 300
@export var FRICTION := 500

@export var maxHealth = 100

@export var bag : Node2D

func _ready():
	pass

func _process(_delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
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
