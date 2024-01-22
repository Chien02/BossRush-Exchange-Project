extends Node2D

class_name StateFactory

@onready var states = {
	"idle" : $"Idle state",
	"run" : $"Run state",
	"dash" : $"Dash state",
	"attack" : $"Attack state",
	"eidle" : $EIdle,
	"echase" : $EChase,
	"eattack" : $EAttack,
	"edead" : $E_dead
}

func get_state(state : String):
	return states[state]
