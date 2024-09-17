extends CanvasLayer

var progress = []
var scene_name: String
var scene_load_status := 0
var done = false

func change_scene(target: String) -> void:
	scene_name = target
	ResourceLoader.load_threaded_request(scene_name)
	$AnimationPlayer.play("fade_in")
	done = false
	
func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_name, progress)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and not $AnimationPlayer.is_playing() and not done:
		var loaded_scene = ResourceLoader.load_threaded_get(scene_name)
		get_tree().change_scene_to_packed(loaded_scene)
		$AnimationPlayer.play_backwards("fade_in")
		done = true
