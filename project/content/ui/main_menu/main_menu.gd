extends CanvasLayer

func _on_play_button_pressed() -> void:
	GameGlobals.logger.log("Play button pressed", Color.YELLOW)
	# TODO: Add functionality
	GameGlobals.scene_admin.switch_scene("PrototypeLevel")

func _on_settings_button_pressed() -> void:
	GameGlobals.logger.log("Settings button pressed", Color.YELLOW)
	# TODO: Add functionality
	
func _on_credits_button_pressed() -> void:
	GameGlobals.logger.log("Credits button pressed", Color.YELLOW)
	# TODO: Add functionality
	
func _on_quit_button_pressed() -> void:
	GameGlobals.logger.log("Quit button pressed", Color.YELLOW)
	get_tree().quit()
