extends Control

@export var back_button: Button
@export var normal_button: Button
@export var adaptive_button: Button


func _ready() -> void:
	back_button.press_event = on_back

	normal_button.press_event = on_normal
	adaptive_button.press_event = on_adaptive


func on_back() -> void:
	GSceneAdmin.switch_scene("MainMenu")


func on_normal() -> void:
	GSceneAdmin.switch_scene("FirstLevel")
	WaveSpawner.adaptive_difficulty = false


func on_adaptive() -> void:
	GSceneAdmin.switch_scene("FirstLevel")
	WaveSpawner.adaptive_difficulty = true
