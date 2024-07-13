class_name GPostProcessing extends CanvasLayer
## GPostProcessing manages post-processing effects.

# Shaders for color blindness and gamma correction.
const COLOR_BLIND_SHADER: Shader = preload("res://content/shader/colorblind.gdshader")
const GAMMA_CORRECTION_SHADER: Shader = preload("res://content/shader/gamma.gdshader")

# ColorRect nodes for color blindness and gamma correction filters.
static var color_blind_filter: ColorRect = null
static var gamma_correction: ColorRect = null

static var fade_filter: ColorRect = null
static var fade_tween: Tween = null

static var instance: GPostProcessing = null

func _ready() -> void:
	self.name = "GPostProcessing"

	# Set the singleton instance.
	instance = self

	# Set as a higher layer so the HUD is also effected.
	layer = 2

	# Initialize and configure the color blindness filter.
	color_blind_filter = ColorRect.new()
	add_child(color_blind_filter)
	color_blind_filter.mouse_filter = Control.MOUSE_FILTER_IGNORE
	color_blind_filter.anchors_preset = Control.PRESET_FULL_RECT
	color_blind_filter.material = ShaderMaterial.new()
	color_blind_filter.material.shader = COLOR_BLIND_SHADER
	color_blind_filter.visible = false

	# Add BackBufferCopy between nodes to allow multiple shaders.
	var back_buffer_copy := BackBufferCopy.new()
	add_child(back_buffer_copy)
	back_buffer_copy.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT

	# Initialize and configure the gamma correction filter.
	gamma_correction = ColorRect.new()
	add_child(gamma_correction)
	gamma_correction.mouse_filter = Control.MOUSE_FILTER_IGNORE
	gamma_correction.anchors_preset = Control.PRESET_FULL_RECT
	gamma_correction.material = ShaderMaterial.new()
	gamma_correction.material.shader = GAMMA_CORRECTION_SHADER

	# Initialize the black fade filter.
	fade_filter = ColorRect.new()
	add_child(fade_filter)
	fade_filter.color = Color(0, 0, 0, 0)
	fade_filter.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_filter.anchors_preset = Control.PRESET_FULL_RECT


## Sets the mode for the color blindness filter based on user settings.
## [mode]: The color blindness filter mode from user settings.
static func set_color_blind_filter_mode(mode: LocalSettings.ColorBlindFilter) -> void:
	if mode == LocalSettings.ColorBlindFilter.NONE:
		color_blind_filter.visible = false
		return

	color_blind_filter.visible = true

	match mode:
		LocalSettings.ColorBlindFilter.PROTANOPIA:
			color_blind_filter.material.set_shader_parameter("mode", 0)
		LocalSettings.ColorBlindFilter.DEUTERANOPIA:
			color_blind_filter.material.set_shader_parameter("mode", 1)
		LocalSettings.ColorBlindFilter.TRITANOPIA:
			color_blind_filter.material.set_shader_parameter("mode", 2)


## Sets the strength of the color blindness filter.
## [strength]: The strength of the color blindness filter.
static func set_colorblind_filter_strength(strength: float) -> void:
	color_blind_filter.material.set_shader_parameter("intensity", strength)


## Sets the strength of the gamma correction filter.
## [strength]: The strength of the gamma correction filter.
static func set_gamma(strength: float) -> void:
	gamma_correction.material.set_shader_parameter("gamma", strength)


# TODO: FIX Tweens not restarting properly.

## Fades the screen to black.
static func fade_to_black() -> void:
	if fade_tween:
		fade_tween.kill()

	fade_tween = instance.create_tween()
	#instance.add_child(fade_tween)
	fade_tween.tween_property(fade_filter, "color:a", 1, 3)


## Fades the screen from black.
static func fade_from_black() -> void:
	fade_filter.color = Color(0, 0, 0, 1)
	if fade_tween:
		fade_tween.kill()

	fade_tween = instance.create_tween()
	fade_tween.tween_property(fade_filter, "color:a", 0, 3)

	#await fade_tween.finished

static func fade_transition(callback: Callable) -> void:
	if fade_tween:
		fade_tween.kill()

	fade_tween = instance.create_tween()
	fade_tween.tween_property(fade_filter, "color:a", 1, 0.5)
	await fade_tween.finished
	fade_tween.stop()
	callback.call()
	fade_tween.tween_property(fade_filter, "color:a", 0, 1)
	fade_tween.play()

	await fade_tween.finished

