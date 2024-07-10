extends CanvasLayer


# On ANY button press, switch to the Main Menu scene, typical for a title screen.
func _input(event: InputEvent) -> void:
	if event.is_pressed():
		GSceneAdmin.switch_scene("MainMenu")
