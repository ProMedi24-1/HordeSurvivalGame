class_name DebugUserSettings
## ImGui User Settings Menu for testing the Settings system.

static var set_res_x := [1024]
static var set_res_y := [600]
static var set_max_fps := [60]
static var set_vsync := [false]
static var set_window_mode := [0]

static var set_gamma := [1.0]
static var set_camera_zoom := [1.0]

static var set_colorblind_mode := [0]
static var set_colorblind_strength := [0.0]
static var set_camera_shake := [true]

static var set_master_volume := [0.0]
static var set_music_volume := [0.0]
static var set_sfx_volume := [0.0]


static func show_user_settings_window(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(280, 420), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(20, 150), ImGui.Cond_Once)

	ImGui.Begin("User Settings", p_open, ImGui.WindowFlags_NoSavedSettings)

	ImGui.Separator()

	set_res_x[0] = LocalSettings.resolution_x
	set_res_y[0] = LocalSettings.resolution_y
	set_max_fps[0] = LocalSettings.max_fps
	set_vsync[0] = LocalSettings.vsync_enabled

	if ImGui.CollapsingHeader("Video"):
		if ImGui.InputInt("res_x", set_res_x):
			LocalSettings.resolution_x = set_res_x[0]
		if ImGui.InputInt("res_y", set_res_y):
			LocalSettings.resolution_y = set_res_y[0]
		if ImGui.InputInt("max_fps", set_max_fps):
			LocalSettings.max_fps = set_max_fps[0]

		set_window_mode[0] = LocalSettings.window_mode
		if ImGui.SliderIntEx(
			"window_mode",
			set_window_mode,
			0,
			LocalSettings.WindowMode.size() - 1,
			LocalSettings.WindowMode.keys()[set_window_mode[0]]
		):
			LocalSettings.window_mode = set_window_mode[0]

		if ImGui.Checkbox("v_sync", set_vsync):
			LocalSettings.vsync_enabled = set_vsync[0]

	if ImGui.CollapsingHeader("Preference"):
		set_gamma[0] = LocalSettings.gamma_value
		set_camera_zoom[0] = LocalSettings.camera_zoom_level
		if ImGui.SliderFloat("gamma", set_gamma, 0.0, 2.0):
			LocalSettings.gamma_value = set_gamma[0]
		if ImGui.SliderFloat("camera_zoom", set_camera_zoom, -0.5, 1.0):
			LocalSettings.camera_zoom_level = set_camera_zoom[0]

	if ImGui.CollapsingHeader("Accessibility"):
		set_colorblind_mode[0] = LocalSettings.color_blind_filter
		set_colorblind_strength[0] = LocalSettings.color_filter_strength
		set_camera_shake[0] = LocalSettings.camera_shake_enabled

		ImGui.Text("colorblind_mode")
		if ImGui.SliderIntEx(
			"##IcolorBlindMode",
			set_colorblind_mode,
			0,
			LocalSettings.ColorBlindFilter.size() - 1,
			LocalSettings.ColorBlindFilter.keys()[set_colorblind_mode[0]]
		):
			LocalSettings.color_blind_filter = set_colorblind_mode[0]
		ImGui.Text("colorblind_strength")
		if ImGui.SliderFloat("##IcolorBlindStrength", set_colorblind_strength, 0.0, 1.0):
			LocalSettings.color_filter_strength = set_colorblind_strength[0]
		ImGui.Text("camera_shake_strength")
		if ImGui.Checkbox("##IcameraShake", set_camera_shake):
			LocalSettings.camera_shake_enabled = set_camera_shake[0]

	if ImGui.CollapsingHeader("Audio"):
		set_master_volume[0] = LocalSettings.master_volume
		set_music_volume[0] = LocalSettings.music_volume
		set_sfx_volume[0] = LocalSettings.sfx_volume

		ImGui.Text("master_volume")
		if ImGui.SliderFloat("##ImasterVolume", set_master_volume, 0.0, 1.5):
			LocalSettings.master_volume = set_master_volume[0]
		ImGui.Text("music_volume")
		if ImGui.SliderFloat("##ImusicVolume", set_music_volume, 0.0, 1.5):
			LocalSettings.music_volume = set_music_volume[0]
		ImGui.Text("sfx_volume")
		if ImGui.SliderFloat("##IsoundVolume", set_sfx_volume, 0.0, 1.5):
			LocalSettings.sfx_volume = set_sfx_volume[0]

	ImGui.Separator()
	if ImGui.Button("Apply Settings"):
		LocalSettings.apply_settings()

	if ImGui.Button("Load"):
		#LocalSettings.loadSettings()
		pass

	ImGui.End()
