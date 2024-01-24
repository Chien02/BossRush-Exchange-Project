extends Node2D

class_name StateFactory

@onready var states = {
	"p_idle": $P_idle,
	"p_run": $P_run,
	"p_dash": $P_dash,
	"p_attack": $P_attack,
	"e_chase": $E_chase,
	"e_attack": $E_attack
}

func get_state(state : String):
	return states[state]
