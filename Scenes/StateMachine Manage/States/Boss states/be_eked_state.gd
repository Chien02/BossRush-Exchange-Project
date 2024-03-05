extends BaseState

var be_eking : bool = false

func _ready():
	_name = "boss_be_eked"

func enter():
	$Timer.start()
	be_eking = true
	
func exit():
	pass

func update():
	handle_be_eked()
	check_for_switch()

func check_for_switch():
	if (!be_eking):
		$AnimatedSprite2D.visible = false
		character.be_eked = false
		switch(state_factory.get_state("boss_idle"))

func _on_timer_timeout():
	be_eking = false

func handle_be_eked(): # Appear the anger sprite
	var animator = $AnimatedSprite2D
	animator.visible = true
	animator.position = character.get_node("AngerPoint").position
	$AnimationPlayer.play("anger")
	
