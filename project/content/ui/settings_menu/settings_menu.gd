extends Control

@export var close_button: Button
@export var apply_button: Button

@export var max_fps_box: SpinBox
@export var vsync_box: CheckBox
@export var window_mode_box: OptionButton

@export var gamma_slider: HSlider
@export var zoom_slider: HSlider

@export var colorblind_filter_box: OptionButton
@export var camera_shake_box: CheckBox

@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider


func _ready() -> void:
	close_button.press_event = close_pressed
	apply_button.press_event = apply_pressed

	max_fps_box.value = LocalSettings.max_fps
	vsync_box.button_pressed = LocalSettings.vsync_enabled
	window_mode_box.clear()

	for mode in LocalSettings.WindowMode.keys():
		window_mode_box.add_item(mode)
	window_mode_box.selected = LocalSettings.window_mode

	gamma_slider.max_value = 2.0
	gamma_slider.value = LocalSettings.gamma_value
	gamma_slider.min_value = 0.5

	zoom_slider.max_value = 1.0
	zoom_slider.min_value = -1.0
	zoom_slider.value = LocalSettings.camera_zoom_level

	colorblind_filter_box.clear()
	for filter in LocalSettings.ColorBlindFilter.keys():
		colorblind_filter_box.add_item(filter)
	colorblind_filter_box.selected = LocalSettings.color_blind_filter

	camera_shake_box.button_pressed = LocalSettings.camera_shake_enabled

	master_slider.max_value = 1.5
	master_slider.value = LocalSettings.master_volume
	music_slider.max_value = 1.5
	music_slider.value = LocalSettings.music_volume
	sfx_slider.max_value = 1.5
	sfx_slider.value = LocalSettings.sfx_volume


## Close the settings menu on escape key press.
func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		close_pressed()


## Close the settings menu.
func close_pressed() -> void:
	self.queue_free()


## Apply the settings.
func apply_pressed() -> void:
	LocalSettings.max_fps = max_fps_box.value as int
	LocalSettings.vsync_enabled = vsync_box.button_pressed
	LocalSettings.window_mode = LocalSettings.WindowMode[window_mode_box.get_item_text(
		window_mode_box.selected
	)]

	LocalSettings.gamma_value = gamma_slider.value
	LocalSettings.camera_zoom_level = zoom_slider.value

	LocalSettings.color_blind_filter = LocalSettings.ColorBlindFilter[
		colorblind_filter_box.get_item_text(colorblind_filter_box.selected)
	]
	LocalSettings.camera_shake_enabled = camera_shake_box.button_pressed

	LocalSettings.master_volume = master_slider.value
	LocalSettings.music_volume = music_slider.value
	LocalSettings.sfx_volume = sfx_slider.value

	LocalSettings.apply_settings()
