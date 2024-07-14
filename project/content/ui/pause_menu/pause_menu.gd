extends Control

@export var continue_button: Button
@export var settings_button: Button
@export var quit_button: Button

@export var settings_scene: PackedScene

func _ready() -> void:
	continue_button.press_event = on_continue
	settings_button.press_event = on_settings
	quit_button.press_event = on_quit

func on_continue() -> void:
	GStateAdmin.unpause_game()
	self.get_parent().queue_free()

func on_quit() -> void:
	GSceneAdmin.switch_scene("MainMenu")
	self.get_parent().queue_free()

func on_settings() -> void:
	var settings = settings_scene.instantiate()
	add_child(settings)

func _input(event: InputEvent) -> void:
	#print("input")
	if event.is_action_pressed("PauseMenu"):
		print("esc pressed")
		#on_continue()
		self.get_parent().queue_free()
