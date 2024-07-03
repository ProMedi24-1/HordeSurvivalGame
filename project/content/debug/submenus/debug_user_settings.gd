class_name DebugUserSettings
# User Settings Menu for testing the Settings system.


static var setResX       := [1024]
static var setResY       := [600]
static var setMaxFPS     := [60]
static var setVsync      := [false]
static var setWindowMode := [0]

static var setGamma := [1.0]
static var setCameraZoom := [1.0]

static var setColorblindMode      := [0]
static var setColorblindStrength  := [0.0]
static var setCameraShake := [true]

static var setMasterVolume := [0.0]
static var setMusicVolume  := [0.0]
static var setSFXVolume    := [0.0]

static func showUserSettingsWindow(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(280, 420), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(20, 150), ImGui.Cond_Once)

	ImGui.Begin("User Settings", p_open, ImGui.WindowFlags_NoSavedSettings)

	ImGui.Separator()

	setResX[0] = LocalSettings.resX
	setResY[0] = LocalSettings.resY
	setMaxFPS[0] = LocalSettings.maxFPS
	setVsync[0] = LocalSettings.vSync

	if ImGui.CollapsingHeader("Video"):
		if ImGui.InputInt("resX", setResX):
			LocalSettings.resX = setResX[0]
		if ImGui.InputInt("resY", setResY):
			LocalSettings.resY = setResY[0]
		if ImGui.InputInt("maxFPS", setMaxFPS):
			LocalSettings.maxFPS = setMaxFPS[0]
		
		setWindowMode[0] = LocalSettings.windowMode
		if ImGui.SliderIntEx("windowMode", setWindowMode, 0, LocalSettings.WindowMode.size() - 1, LocalSettings.WindowMode.keys()[setWindowMode[0]]):
			LocalSettings.windowMode = setWindowMode[0]

		if ImGui.Checkbox("VSync", setVsync):
			LocalSettings.vSync = setVsync[0]

	if ImGui.CollapsingHeader("Preference"):
		setGamma[0] = LocalSettings.gamma
		setCameraZoom[0] = LocalSettings.cameraZoom
		if ImGui.SliderFloat("gamma", setGamma, 0.0, 2.0):
			LocalSettings.gamma = setGamma[0]
		if ImGui.SliderFloat("cameraZoom", setCameraZoom, -0.5, 1.0):
			LocalSettings.cameraZoom = setCameraZoom[0]

	if ImGui.CollapsingHeader("Accessibility"):

		setColorblindMode[0] = LocalSettings.colorBlindFilter
		setColorblindStrength[0] = LocalSettings.colorFilterStrength
		setCameraShake[0] = LocalSettings.cameraShake
		
		ImGui.Text("colorblindMode")
		if ImGui.SliderIntEx("##IcolorBlindMode", setColorblindMode, 0, LocalSettings.ColorBlindFilter.size() - 1, LocalSettings.ColorBlindFilter.keys()[setColorblindMode[0]]):
			LocalSettings.colorBlindFilter = setColorblindMode[0]
		ImGui.Text("colorblindStrength")
		if ImGui.SliderFloat("##IcolorBlindStrength", setColorblindStrength, 0.0, 1.0):
			LocalSettings.colorFilterStrength = setColorblindStrength[0]
		ImGui.Text("cameraShakeStrength")
		if ImGui.Checkbox("##IcameraShake", setCameraShake):
			LocalSettings.cameraShake = setCameraShake[0]


	if ImGui.CollapsingHeader("Audio"):
		setMasterVolume[0] = LocalSettings.masterVolume
		setMusicVolume[0] = LocalSettings.musicVolume
		setSFXVolume[0] = LocalSettings.sfxVolume

		ImGui.Text("Master Volume")
		if ImGui.SliderFloat("##ImasterVolume", setMasterVolume, 0.0, 1.5):
			LocalSettings.masterVolume = setMasterVolume[0]
		ImGui.Text("Music Volume")
		if ImGui.SliderFloat("##ImusicVolume", setMusicVolume, 0.0, 1.5):
			LocalSettings.musicVolume = setMusicVolume[0]
		ImGui.Text("SFX Volume")
		if ImGui.SliderFloat("##IsoundVolume", setSFXVolume, 0.0, 1.5):
			LocalSettings.sfxVolume = setSFXVolume[0]


	ImGui.Separator()
	if ImGui.Button("Apply Settings"):
		LocalSettings.applySettings()	

	if ImGui.Button("Load"):
		#LocalSettings.loadSettings()
		pass

	ImGui.End()
