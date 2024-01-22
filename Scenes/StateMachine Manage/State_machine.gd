extends Node2D
# Đây là class sẽ giao tiếp với player, lấy thông tin của player chẳng hạn như vị trí
# để truyền cho các current state phục vụ mục đích của nó
class_name StateMachine

@export var animator : Animation_Control

@onready var player = $".." #relative
@onready var base_state  = $"Base State"
@onready var state_factory = $StateFactory

var current_state : BaseState

func _ready():
	# Set the default state for current state
	print(player.name)
	current_state = state_factory.get_state("idle")
	#if (player.name == "Player"):
		#current_state = state_factory.get_state("idle") #player is playe
	get_info()
	current_state.enter()

func _process(_delta):
	get_info() # Use this to update info of player every frame or every time change state
	current_state.update() # Use the process of current state

func get_info():
	current_state.state_factory = state_factory
	current_state.state_machine = self
	current_state.player = player

