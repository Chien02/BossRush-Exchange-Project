extends CanvasLayer

var progress = []
var scene_name
var scene_load_status = 0

func _ready():
	scene_name = "res://Scenes/test_scene.tscn"
	ResourceLoader.load_threaded_request(scene_name)

func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_name, progress)
	$loading/Label.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(scene_name)
		get_tree().change_scene_to_packed(new_scene)
