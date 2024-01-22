extends State

class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 30.0
var moveDirection : Vector2
var wanderTime : float
var player : CharacterBody2D 
func randomizeWander():
	moveDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wanderTime = randf_range(1, 2)

func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomizeWander()

func update(delta: float):
	if wanderTime > 0 : 
		wanderTime -= delta
	else:
		randomizeWander()

func physicsUpdate(delta: float):
	if enemy:
		enemy.velocity = moveDirection * move_speed
	var direction = player.global_position - enemy.global_position
	
	#if direction.length() < 30:
		#print("Idle== test")
