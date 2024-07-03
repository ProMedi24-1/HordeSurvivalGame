class_name DebugOverlay
# ImGui Overlay that shows Admin Status and other info.


static func showOverlayWindow(p_open: Array) -> void:
	const flags := ImGui.WindowFlags_NoMove| \
					ImGui.WindowFlags_NoDecoration| \
					ImGui.WindowFlags_NoSavedSettings| \
					ImGui.WindowFlags_AlwaysAutoResize

	ImGui.SetNextWindowBgAlpha(0.35)
	ImGui.SetNextWindowPos(Vector2(10, 30), ImGui.Cond_Always)
	ImGui.Begin("Overlay", p_open, flags)

	ImGui.SeparatorText("Global Admins")
	if ImGui.TreeNode("Scene Admin"):
		ImGui.Text("Current Scene: " + str(GSceneAdmin.sceneRoot.name))
		ImGui.Text("Current Scene Root: " + str(GSceneAdmin.sceneRoot))
		ImGui.Text("Current Level Component: " + str(GSceneAdmin.levelBase))
		ImGui.TreePop()

	if ImGui.TreeNode("State Admin"):
		ImGui.Text("Current State: " + GStateAdmin.GameState.keys()[GStateAdmin.gameState])
		if GStateAdmin.gamePaused:
			ImGui.TextColored(Color.YELLOW, "GAME PAUSED")
		ImGui.TreePop()
	
	if ImGui.TreeNode("Entity Admin"):
		ImGui.Text("Entity Count: " + str(GEntityAdmin.entities.size()))
		ImGui.Text("Player: " + str(GEntityAdmin.player))
		ImGui.TreePop()

	ImGui.End()


	# Overlay 2
	ImGui.SetNextWindowBgAlpha(0.35)

	var vp := GGameGlobals.instance.get_viewport()
	ImGui.SetNextWindowPos(Vector2(vp.size.x - 200, 30))

	ImGui.Begin("Overlay 2", p_open, flags)
	
	ImGui.Text("Window size: %d, %d" % [vp.size.x, vp.size.y])
	ImGui.Text("Mouse pos: %d, %d" % [vp.get_mouse_position().x, vp.get_mouse_position().y])
	ImGui.Separator()
	if ImGui.TreeNodeEx("Info", ImGui.TreeNodeFlags_DefaultOpen):
		ImGui.Text("Debug-build: " + str(OS.is_debug_build()))
		ImGui.Text("Platform: " + OS.get_name())
		ImGui.Text("Locale: " + OS.get_locale())
		ImGui.Text("Using ImGui " + ImGui.GetVersion())
		ImGui.TreePop()

	ImGui.End()