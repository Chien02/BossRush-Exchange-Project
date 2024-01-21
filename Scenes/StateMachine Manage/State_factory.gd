extends Node2D

class_name StateFactory

@onready var states = {
	"idle" : $"Idle state",
	"run" : $"Run state",
	"dash" : $"Dash state",
	"attack" : $"Attack state"
}

func get_state(state : String):
	return states[state]

func init_state():
	return states["idle"]
