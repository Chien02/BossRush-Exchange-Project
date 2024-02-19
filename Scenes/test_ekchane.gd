extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var list = $p1.get_children()
	
	if (Input.is_action_just_pressed("ek")):
		var new_child = Weapons.get_weapon("TreeHammer")
		$p1.add_child(new_child)
	if (Input.is_action_just_pressed("ui_accept")):
		var new_child = Weapons.get_weapon("LightingSword")
		$p1.add_child(new_child)
	if (Input.is_action_just_pressed("exit_aim")):
		var old_child
		for child in list:
			if (child is Weapon_base):
				if (child.wpn_name == "TreeHammer"):
					old_child = child
		if (old_child):
			old_child.queue_free()
	
	for child in list:
		if child.is_in_group("Weapon"):
			print(child.wpn_name)
			$p1/avatar.texture = child.icon
	
	if $p1/avatar.texture == null:
		$p1/avatar.texture = null
