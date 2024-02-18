extends CanvasLayer

@onready var animation = $Button/Restart/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		restart()


func _on_button_button_down():
	animation.play("press")

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
