class_name DebugMenuBarOld
extends DebugUiBase

static var debug_overlay := DebugOverlay.new()
static var debug_tools := [
	DebugLogger.new(), 
	DebugProfiler.new(), 
	DebugEntityInspector.new(),
	DebugLevelOverview.new(),
	DebugPlayerMenu.new(),
]

static var show_imgui_demo := [false]

func add_to_scene(element) -> void:
	add_child(element)
	element.name = element.ui_name

func _init() -> void:
	super("MenuBar", true)

	add_to_scene(debug_overlay)

	for tool in debug_tools:
		add_to_scene(tool)


func draw_contents(_p_show: Array = [true]) -> void:
	ImGui.BeginMainMenuBar()
	
	if show_imgui_demo[0]:
		ImGui.ShowDemoWindow(show_imgui_demo)

	if ImGui.BeginMenu("Scenes"):
		draw_scenes_menu()
		ImGui.EndMenu()

	if ImGui.BeginMenu("Overlay"):
		draw_overlay_menu()
		ImGui.EndMenu()

	if ImGui.BeginMenu("Tools"):
		draw_tools_menu()
		ImGui.EndMenu()

	if ImGui.BeginMenu("Misc"):
		draw_misc_menu()
		ImGui.EndMenu()

	ImGui.EndMainMenuBar()

func draw_scenes_menu() -> void:
	if ImGui.BeginMenu("Switch Scene"):
		for scene in GameGlobals.scene_admin.scenes:
			if ImGui.MenuItem(scene):
				GameGlobals.scene_admin.switch_scene(scene)

		ImGui.EndMenu()

	if ImGui.MenuItem("Quit Game"):
			get_tree().quit()

func draw_overlay_menu() -> void:
	if ImGui.MenuItem("Show"):
		debug_overlay.show[0] = true
		GameGlobals.logger.log("Show Overlay", Color.DODGER_BLUE)
	if ImGui.MenuItem("Hide"):
		debug_overlay.show[0] = false
		GameGlobals.logger.log("Hide Overlay", Color.DODGER_BLUE)

func draw_tools_menu() -> void:
	for tool in debug_tools:
		if ImGui.MenuItem(tool.name):
			tool.show[0] = true
			GameGlobals.logger.log("Show " + tool.name, Color.DODGER_BLUE)

func draw_misc_menu() -> void:
	if ImGui.MenuItem("ImGui Demo"):
		show_imgui_demo[0] = true
		GameGlobals.logger.log("Show ImGui Demo", Color.DODGER_BLUE)
