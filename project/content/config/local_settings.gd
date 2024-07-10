class_name LocalSettings
## Class to manage local settings such as display and audio preferences.

## Enum for window display modes.
enum WindowMode {
	WINDOWED,
	BORDERLESS,
	FULLSCREEN,
}

## Enum for types of color blindness filters.
enum ColorBlindFilter { NONE, PROTANOPIA, DEUTERANOPIA, TRITANOPIA }

# Resolution settings
static var resolution_x: int = 1024  ## Horizontal resolution.
static var resolution_y: int = 600  ## Vertical resolution.
static var max_fps: int = 144  ## Maximum frames per second. 0 for unlimited.
static var vsync_enabled: bool = false  ## Vertical sync setting.
static var window_mode: int = WindowMode.WINDOWED  ## Current window mode.

# Display settings
static var gamma_value: float = 1.0  ## Gamma correction value.
static var camera_zoom_level: float = 0.0  ## Camera zoom level.

# Color and visual effect settings
static var color_blind_filter := ColorBlindFilter.NONE  ## Type of color blindness filter.
static var color_filter_strength: float = 1.0  ## Strength of the color filter.
static var camera_shake_enabled: bool = true  ## Toggle for camera shake effect.

# Audio settings
static var master_volume: float = 0.75  ## Master volume level.
static var music_volume: float = 1.0  ## Music volume level.
static var sfx_volume: float = 1.0  ## Sound effects volume level.


## Applies the user-defined settings to the game.
static func apply_settings() -> void:
	apply_video_settings()
	apply_preference_settings()
	apply_accessibility_settings()
	apply_audio_settings()


static func apply_video_settings() -> void:
	Engine.set_max_fps(max_fps)

	# Determine the VSync mode based on the user's choice and apply it.
	var vsync_mode = DisplayServer.VSYNC_ENABLED if vsync_enabled else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(vsync_mode)

	# Apply the window mode based on the user's selection.
	match window_mode:
		WindowMode.WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		WindowMode.BORDERLESS:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		WindowMode.FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


static func apply_preference_settings() -> void:
	GPostProcessing.set_gamma(gamma_value)
	if GEntityAdmin.player:
		GEntityAdmin.player.camera_zoom_offset = camera_zoom_level
		GEntityAdmin.player.set_camera_zoom()


static func apply_accessibility_settings() -> void:
	GPostProcessing.set_color_blind_filter_mode(color_blind_filter)
	GPostProcessing.set_colorblind_filter_strength(color_filter_strength)


static func apply_audio_settings() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_volume))


static func load_settings_from_json() -> void:
	# TODO: Implement.
	pass


static func save_settings_to_json() -> void:
	# TODO: Implement.
	pass
