extends State

class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 20.0
var moveDirection : Vector2
var wanderTime : float

func randomizeWander():
	moveDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wanderTime = randf_range(1, 3)

func enter():
	randomizeWander()

func update(delta: float):
	if wanderTime > 0 : 
		wanderTime -= delta
	else:
		randomizeWander()

func physicsUpdate(delta: float):
	if enemy:
		enemy.velocity = moveDirection * move_speed
