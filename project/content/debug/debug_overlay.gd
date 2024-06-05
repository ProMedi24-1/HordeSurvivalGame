class_name DebugOverlay
extends DebugUiBase

var window_init: bool = false

func _init() -> void:
	super("Overlay", true)

func draw_contents(p_show: Array = [true]) -> void:
	draw_admin_contents(p_show)
	draw_stats_contents(p_show)

func draw_admin_contents(p_show: Array = [true]) -> void:
	ImGui.SetNextWindowBgAlpha(0.35)

	if not window_init:
		window_init = true
		ImGui.SetNextWindowPos(Vector2(10, 30))

	if ImGui.Begin("Admin Overlay", p_show,
			ImGui.WindowFlags_NoMove |
			ImGui.WindowFlags_NoDecoration |
			ImGui.WindowFlags_NoSavedSettings |
			ImGui.WindowFlags_AlwaysAutoResize):
		
		ImGui.SeparatorText("Global Admins")
		if ImGui.TreeNode("Scene Admin"):
			ImGui.Text("Current Scene: " + str(SceneAdmin.scene_root.name))
			ImGui.Text("Current Scene Root: " + str(SceneAdmin.scene_root))
			ImGui.Text("Current Level Component: " + str(SceneAdmin.level_component))
			ImGui.TreePop()

		if ImGui.TreeNode("State Admin"):
			ImGui.Text("Current State: " + StateAdmin.enum_strings[StateAdmin.game_state])
			if StateAdmin.game_paused:
				ImGui.TextColored(Color.YELLOW, "GAME PAUSED")
			ImGui.TreePop()
		
		if ImGui.TreeNode("Entity Admin"):
			ImGui.Text("Entity Count: " + str(EntityAdmin.entities.size()))
			ImGui.Text("Player: " + str(EntityAdmin.player))
			ImGui.TreePop()
	   
	ImGui.End()

func draw_stats_contents(p_show: Array = [true]) -> void:
	ImGui.SetNextWindowBgAlpha(0.35)

	ImGui.SetNextWindowPos(Vector2(get_viewport().size.x - 200, 30))

	if ImGui.Begin("Stats Overlay", p_show,
			ImGui.WindowFlags_NoMove |
			ImGui.WindowFlags_NoDecoration |
			ImGui.WindowFlags_NoSavedSettings |
			ImGui.WindowFlags_AlwaysAutoResize):

		ImGui.Text("FPS: " + str(Performance.get_monitor(Performance.TIME_FPS)))
		ImGui.Text("Frametime: %.2f ms" % (Performance.get_monitor(Performance.TIME_PROCESS) * 1000))

		ImGui.Separator()

		ImGui.Text("Window size: %d, %d" % [get_viewport().size.x, get_viewport().size.y])
		ImGui.Text("Mouse pos: %d, %d" % [get_viewport().get_mouse_position().x,
										 get_viewport().get_mouse_position().y])
		ImGui.Separator()
		if ImGui.TreeNode("Info"):
			ImGui.Text("Debug-build: " + str(OS.is_debug_build()))
			ImGui.Text("Platform: " + OS.get_name())
			ImGui.Text("Locale: " + OS.get_locale())
			ImGui.Text("Using ImGui " + ImGui.GetVersion())
			ImGui.TreePop()
		ImGui.End()        
		
