extends Control

@export var wave_label: Label
@export var continue_button: Button

func _ready() -> void:
	wave_label.text = "Wave " + str(WaveSpawner.current_wave) + " completed!"
	continue_button.press_event = on_continue

func on_continue() -> void:
	GStateAdmin.unpause_game()
	WaveSpawner.wave_ref.start_wave()
	self.queue_free()


