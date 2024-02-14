extends Control

class_name Energy

@export var max_energy : int = 5
@onready var energy_bar = $TextureProgressBar
var energy : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	init_energy()
	Global.player_energy = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Global.player_energy.energy = self.energy
	@warning_ignore("integer_division")
	energy_bar.value = energy * 20

func init_energy():
	energy = 3

func add_energy(value: int):
	var tween = create_tween()
	tween.tween_property(energy_bar, "scale", Vector2(1.2, 1.2), 0.3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	await tween.finished
	energy += value
	tween = create_tween()
	tween.tween_property(energy_bar, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	#scale_down()
	if (energy >= max_energy):
		energy = max_energy

func decrease_energy(value: int):
	scale_up()
	energy -= value
	#scale_down()
	if (energy <= 0):
		energy = 0


func scale_up():
	pass

func scale_down():
	var tween = create_tween()
	tween.tween_property(energy_bar, "scale", Vector2(0.8, 0.8), 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

