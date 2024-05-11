extends CanvasLayer

func _on_continue_button_pressed() -> void:
    self.queue_free()

func _on_quit_button_pressed() -> void:
    self.queue_free()



