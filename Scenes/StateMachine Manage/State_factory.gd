extends Node2D

class_name StateFactory

@onready var states = {
	"p_idle": $"Player state/Idle state",
	"p_run": $"Player state/Run state",
	"p_dash": $"Player state/Dash state",
	"p_attack": $"Player state/Attack state",
	"p_hurt": $"Player state/Hurt state",
	"p_dead": "null",
	"ek_idle": $"Player state/Ek_idle",
	"ek_run": $"Player state/Ek_run",
	"ek_dash": $"Player state/Ek_dash",
	"ek_attack": $"Player state/Ek_attack",
	"ek_hurt": $"Player state/Ek_hurt",
	"ek_transform": $"Player state/Ek_transform",
	"ek_deform": $"Player state/Ek_deform",
	"ek_special": $"Player state/Ek special",
	"e_chase": $"Enemy state/EChase",
	"e_attack": $"Enemy state/EAttack",
	"e_dead": $"Enemy state/EDead",
	"boss_idle": $"Boss state/BIdle",
	"boss_chase": $"Boss state/BChase",
	"boss_sweep" : $"Boss state/BSweep",
	"boss_attack": $"Boss state/BAttack",
	"boss_hurt": $"Boss state/BHurt",
	"boss_be_eked": $"Boss state/BeEked state",
	"boss_rage": null,
	"boss_dead": "null"
}

func get_state(state : String):
	return states[state]
