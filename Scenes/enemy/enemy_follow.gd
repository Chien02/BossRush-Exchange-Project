extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 30.0
@export var distance := 50
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physicsUpdate(delta: float):
	var direction = player.global_position - enemy.global_position
	#print("test===========")
	#print(direction.length())
	if direction.length() < 70 :
		enemy.velocity = direction.normalized() * move_speed
	#if direction.length() > 50:
		#print("test == Idle")
	else:
		enemy.velocity = Vector2()
		
	
