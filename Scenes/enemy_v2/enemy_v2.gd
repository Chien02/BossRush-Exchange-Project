extends CharacterBody2D
class_name Enemy
#Health
@onready var healthBar = $HealthBar

@export var SPEED := 70
@export var animation_control : Node2D
var chase : bool = false
var attack : bool = false
var direction : Vector2 = Vector2.ZERO
var player : CharacterBody2D
#health
var health

func _ready():
	health = 60	
	player = get_parent().get_parent().get_node("Player")
	if (player): print(player.name)
	
	#health bar - Author: Thanh Toan
	healthBar.initHealth(health)

func _process(delta):
	animation_control.update_paramater_animation(direction)

func _on_area_2d_body_entered(body):
	if (body.is_in_group("Player")):
		attack = true
		chase = false

func _on_area_2d_body_exited(body):
	if (body.is_in_group("Player")):
		attack = false
		chase = true


func _on_hurtbox_area_entered(_area):
	if (_area.is_in_group("Player")):
		print("Get hit")
		health -= 2 # Test health (khong thanh cong)
		var tween = create_tween()
		tween.tween_property(get_parent(), "scale", Vector2(1, 1) * 0.6, 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
		tween.tween_property(get_parent(), "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)


#set new health
func _set_health(new_health):
	var pre_health = health
	health = min(healthBar.max_value, new_health)
	healthBar.value = health
	
	if health <= 0:
		print("Dead")
	
	if health < pre_health:
		healthBar.timer.start()
	else:
		healthBar.damageBar.value = health
