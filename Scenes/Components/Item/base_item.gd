extends Area2D
class_name Item

signal be_picked_up(name)

@export var sprite : Texture

func _ready():
	$Sprite2D.texture = sprite if (sprite) else null

func _on_body_entered(body):
	if (body.is_in_group("Player")):
		send_info(body)

func send_info(body):
	body.slot.switch(self.name)
