class_name GGameGlobals extends Node
## GGameGlobals is a singleton class designed to initialize
## and manage the global game admins and systems.

## Static reference to the GGameGlobals singleton instance.
static var instance: GGameGlobals = null


# Initializes the singleton instance and sets up the game environment.
func _ready() -> void:
	self.name = "GGameGlobals"
	instance = self

	var is_debug := OS.is_debug_build()
	var platform := OS.get_name()

	# Load and set the custom cursor image.
	#var cursor = load("res://assets/ui/cursor_24.png")
	#Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(0, 0))

	if is_debug:
		add_debug_menus()

		GLogger.log("Running Debug-Build.", Color.YELLOW)
		GLogger.log("Platform: " + platform, Color.YELLOW)
	else:
		GLogger.log("Running Release-Build.", Color.YELLOW)

	# Add core global game nodes as children.
	add_child(GSceneAdmin.new())
	add_child(GStateAdmin.new())
	add_child(GEntityAdmin.new())
	add_child(GPostProcessing.new())


## Adds debug imgui-menus to the game, used for development and testing.
func add_debug_menus() -> void:
	setup_imgui()

	add_child(DebugMenuBar.new())


## Configures ImGui settings for the game's debug menus.
func setup_imgui() -> void:
	# Enable docking feature in ImGui.
	var io := ImGui.GetIO()
	io.ConfigFlags |= ImGui.ConfigFlags_DockingEnable

	# Set style properties for ImGui, e.g., rounded corners for windows.
	var style := ImGui.GetStyle()
	style.WindowRounding = 10.0
