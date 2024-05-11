class_name DebugMenuBar
extends DebugUiBase

static var debug_overlay

static var debug_logger
static var debug_profiler

static var show_imgui_demo := [false]

func _init() -> void:
    super("DebugMenuBar", true)

    debug_overlay = DebugOverlay.new()
    add_child(debug_overlay)
    debug_overlay.name = "DebugOverlay"

    debug_logger = DebugLogger.new()
    add_child(debug_logger)
    debug_logger.name = "DebugLogger"

    debug_profiler = DebugProfiler.new()
    add_child(debug_profiler)
    debug_profiler.name = "DebugProfiler"

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
    if ImGui.MenuItem("Logger"):
        debug_logger.show[0] = true
        GameGlobals.logger.log("Show Logger", Color.DODGER_BLUE)

    if ImGui.MenuItem("Profiler"):
        debug_profiler.show[0] = true
        GameGlobals.logger.log("Show Profiler", Color.DODGER_BLUE)

    if ImGui.MenuItem("Player Menu"):

        GameGlobals.logger.log("Show Player Menu", Color.DODGER_BLUE)

    if ImGui.MenuItem("Enemy Menu"):

        GameGlobals.logger.log("Show Enemy Menu", Color.DODGER_BLUE)

    if ImGui.MenuItem("Settings Menu"):

        GameGlobals.logger.log("Show Settings Menu", Color.DODGER_BLUE)
    
func draw_misc_menu() -> void:
    if ImGui.MenuItem("ImGui Demo"):
        show_imgui_demo[0] = true
        GameGlobals.logger.log("Show ImGui Demo", Color.DODGER_BLUE)
