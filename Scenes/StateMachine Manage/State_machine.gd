extends Node2D
# Đây là class sẽ giao tiếp với player, lấy thông tin của player chẳng hạn như vị trí
# để truyền cho các current state phục vụ mục đích của nó
class_name StateMachine

@export var animator : Node2D
@export var character : CharacterBody2D # người dùng State Machine

@onready var state_factory = $StateFactory
@onready var base_state = $"Base State"

var current_state : BaseState

func _ready():
	current_state = state_factory.get_state("p_idle")
	get_info()
	current_state.enter()

func _process(_delta):
	get_info() # Use this to update info of player every frame or every time change state
	current_state.update() # Use the process of current state

func get_info():
	current_state.state_factory = state_factory
	current_state.state_machine = self
	current_state.character = character

