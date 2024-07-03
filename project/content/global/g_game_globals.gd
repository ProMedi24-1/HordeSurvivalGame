class_name GGameGlobals extends Node


static var instance: GGameGlobals = null


func _ready() -> void:
	instance = self

	var isDebug := OS.is_debug_build()
	var platform := OS.get_name()

	if isDebug:
		addDebugMenus()

		GLogger.log("Running Debug-Build.", Color.YELLOW)
		GLogger.log("Platform: " + platform, Color.YELLOW)
	else:
		GLogger.log("Running Release-Build.", Color.YELLOW)

	add_child(GSceneAdmin.new())
	add_child(GStateAdmin.new())
	add_child(GEntityAdmin.new())
	add_child(GPostProcessing.new())


func addDebugMenus() -> void:
	setupImgui()

	add_child(DebugMenuBar.new())


func setupImgui() -> void:
	# Config -> enable Docking feature.
	var io := ImGui.GetIO()
	io.ConfigFlags |= ImGui.ConfigFlags_DockingEnable

	# Style -> Rounded Corners
	var style := ImGui.GetStyle()
	style.WindowRounding = 10.0
