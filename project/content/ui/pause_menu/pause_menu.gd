extends CanvasLayer

func _on_continue_button_pressed() -> void:
	print("cool")
	GStateAdmin.unpauseGame()
	#self.queue_free()

func _on_quit_button_pressed() -> void:
	print("cool")
	GSceneAdmin.switchScene("MainMenu")
