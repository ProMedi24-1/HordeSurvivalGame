class_name LocalSettings
# Class for handling user settings.


enum WindowMode {
    WINDOWED,
    BORDERLESS,
    EXCLUSIVE,
}

enum ColorBlindFilter {
    NONE,
    PROTANOPIA,
    DEUTERANOPIA,
    TRITANOPIA
}

# Member Variables
# Video
static var resX: int       = 1024
static var resY: int       = 600
static var maxFPS: int     = 144 # 0 will not limit.
static var vSync: bool     = false
static var windowMode: int = WindowMode.WINDOWED

# Preference
static var gamma: float = 1.0
static var cameraZoom: float = 0.0

# Accessibility
static var colorBlindFilter: int      = ColorBlindFilter.NONE
static var colorFilterStrength: float = 1.0
static var cameraShake: bool          = true

# Audio
static var masterVolume: float = 0.75
static var musicVolume: float  = 1.0
static var sfxVolume: float    = 1.0


static func applySettings() -> void:
    # Video
    DisplayServer.window_set_size(Vector2(resX, resY))
    Engine.set_max_fps(maxFPS)

    var vsyncMode = DisplayServer.VSYNC_ENABLED if vSync else DisplayServer.VSYNC_DISABLED
    DisplayServer.window_set_vsync_mode(vsyncMode)

    match windowMode:
        WindowMode.WINDOWED:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
        WindowMode.BORDERLESS:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
        WindowMode.EXCLUSIVE:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

    # Preference
    GPostProcessing.setGamma(gamma)

    if GEntityAdmin.player:
        GEntityAdmin.player.cameraZoomOffset = cameraZoom
        GEntityAdmin.player.setCameraZoom()

    # Accessibility
    GPostProcessing.setColorblindFilterMode(colorBlindFilter)
    GPostProcessing.setColorblindFilterStrength(colorFilterStrength)
   

    # Audio
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(masterVolume))
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(musicVolume))
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfxVolume))

static func loadSettingsfromJson() -> void:
    # TODO: Implement.
    pass


static func saveSettingsToJson() -> void:
    # TODO: Implement.
    pass
