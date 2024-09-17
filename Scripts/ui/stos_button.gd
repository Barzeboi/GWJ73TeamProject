extends BaseButton
class_name StosButton # Scene to Scene Button

@export var target_scene: String
@export var transition_name: String

func _pressed():
	if target_scene:
		if transition_name:
			SceneTransition.change_scene(target_scene)
		else:
			get_tree().change_scene_to_file(target_scene)
	else:
		printerr("No scene affected to StosButton")
