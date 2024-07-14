extends CanvasLayer

@export var restart_button: Button
@export var quit_button: Button


func _ready() -> void:
	restart_button.press_event = on_restart
	quit_button.press_event = on_quit
	GStateAdmin.can_pause = false

func on_restart() -> void:
	GSceneAdmin.reload_scene()
	GStateAdmin.can_pause = true
	self.queue_free()


func on_quit() -> void:
	GSceneAdmin.switch_scene("MainMenu")
	self.queue_free()
