extends CanvasLayer

@export var play_button: Button
@export var settings_button: Button
@export var credits_button: Button
@export var quit_button: Button

@export var settings_scene: PackedScene
@export var credits_scene: PackedScene


func _ready() -> void:
	play_button.press_event = play_pressed
	settings_button.press_event = settings_pressed
	credits_button.press_event = credits_pressed
	quit_button.press_event = quit_pressed

	Sound.play_music(Sound.Music.MAIN_MENU)

func play_pressed() -> void:
	GSceneAdmin.switch_scene("LevelMenu")


func settings_pressed() -> void:
	var settings := settings_scene.instantiate()
	add_child(settings)


func credits_pressed() -> void:
	var credits := credits_scene.instantiate()
	add_child(credits)


func quit_pressed() -> void:
	get_tree().quit()
