extends Node2D

class_name StateMachine

@export var player : Player
@export var animator : Animation_Control
@export var base_state : BaseState
@export var state_factory : StateFactory

var current_state : BaseState
	
func _ready():
	current_state = state_factory.init_state()

func _process(_delta):
	current_state.update()
	
