extends CharacterBody2D

@onready var slot = $BaseSlot
@onready var animation_tree = $AnimationTree
@onready var animation_control = $AnimationControl
@onready var direction : Vector2 = Vector2.ZERO

@export var SPEED := 50
@export var ACCELERATION := 300
@export var FRICTION := 500
@export var item : String

func _ready():
	slot.item = item
	
func _process(_delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	animation_control.update_paramater_animation(direction)
	
func _physics_process(delta):
	movement(delta)
	
func slot_control():
	if (!slot): return
	slot.display()
	
func movement(delta):
	# This variable is used for calculate velocity
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)# Acceleration
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) # Deceleration
	move_and_slide() # Moving
