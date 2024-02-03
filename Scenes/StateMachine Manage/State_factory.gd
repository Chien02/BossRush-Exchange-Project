extends Node2D

class_name StateFactory

@onready var states = {
	"p_idle": $"Player state/Idle state",
	"p_run": $"Player state/Run state",
	"p_dash": $"Player state/Dash state",
	"p_attack": $"Player state/Attack state",
	"p_hurt": $"Player state/Hurt state",
	"p_dead": "null",
	"e_chase": $"Enemy state/EChase",
	"e_attack": $"Enemy state/EAttack",
	"e_dead": $"Enemy state/EDead",
	"boss_idle": $"Boss state/BIdle",
	"boss_chase": $"Boss state/BChase",
	"boss_sweep" : $"Boss state/BSweep",
	"boss_attack": "null",
	"boss_hurt": $"Boss state/BHurt",
	"boss_dead": "null"
}

func get_state(state : String):
	return states[state]
