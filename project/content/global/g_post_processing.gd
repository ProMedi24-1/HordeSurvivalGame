class_name GPostProcessing extends CanvasLayer



static var colorBlindFilter: ColorRect = null
static var gammaCorrection: ColorRect = null

const COLOR_BLIND_SHADER: Shader = preload("res://content/shader/colorblind.gdshader")
const GAMMA_CORRECTION_SHADER: Shader = preload("res://content/shader/gamma.gdshader")

func _ready() -> void:
	name = "GPostProcessing"

	# Set as a higher layer so the HUD is also effected.
	layer = 2 
  
	colorBlindFilter = ColorRect.new()
	add_child(colorBlindFilter)
	colorBlindFilter.mouse_filter = Control.MOUSE_FILTER_IGNORE
	colorBlindFilter.anchors_preset = Control.PRESET_FULL_RECT
	colorBlindFilter.material = ShaderMaterial.new()
	colorBlindFilter.material.shader = COLOR_BLIND_SHADER
	colorBlindFilter.visible = false

	# Add BackBufferCopy for to allow multiple shaders.
	var backBufferCopy := BackBufferCopy.new()
	add_child(backBufferCopy)
	backBufferCopy.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT

	gammaCorrection = ColorRect.new()
	add_child(gammaCorrection)
	gammaCorrection.mouse_filter = Control.MOUSE_FILTER_IGNORE
	gammaCorrection.anchors_preset = Control.PRESET_FULL_RECT
	gammaCorrection.material = ShaderMaterial.new()
	gammaCorrection.material.shader = GAMMA_CORRECTION_SHADER
		

static func setColorblindFilterMode(mode: LocalSettings.ColorBlindFilter) -> void:
	if mode == LocalSettings.ColorBlindFilter.NONE:
		colorBlindFilter.visible = false
		return

	colorBlindFilter.visible = true

	match mode:
		LocalSettings.ColorBlindFilter.PROTANOPIA:
			colorBlindFilter.material.set_shader_parameter("mode", 0)
		LocalSettings.ColorBlindFilter.DEUTERANOPIA:
			colorBlindFilter.material.set_shader_parameter("mode", 1)
		LocalSettings.ColorBlindFilter.TRITANOPIA:
			colorBlindFilter.material.set_shader_parameter("mode", 2)

static func setColorblindFilterStrength(strength: float) -> void:
	colorBlindFilter.material.set_shader_parameter("intensity", strength)    

static func setGamma(strength: float) -> void:
	gammaCorrection.material.set_shader_parameter("gamma", strength)
