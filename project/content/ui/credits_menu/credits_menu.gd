extends Control

@export var close_button: Button


func _ready() -> void:
	close_button.press_event = close_pressed


func close_pressed() -> void:
	self.queue_free()
