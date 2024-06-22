class_name DebugMenuBar
extends Node

func _ready() -> void:
	self.name = "DebugMenuBar"
	GLogger.log("DebugMenuBar ready", Color.DODGER_BLUE)

static var showDemo := [false]

func _process(_delta: float) -> void:
	ImGui.BeginMainMenuBar()

	showGameMenu()
	showScenesMenu()
	showSettingsMenu()
	showGameplayMenu()
	showLevelMenu()
	showProfilingMenu()

	if showDemo[0]:
		ImGui.ShowDemoWindow(showDemo)

	if ImGui.BeginMenu("Misc"):
		if ImGui.MenuItem("ImGui Demo"):
			showDemo[0] = !showDemo[0]
		ImGui.EndMenu()

	ImGui.EndMainMenuBar()

func showGameMenu() -> void:
	if ImGui.BeginMenu("Game"):
		if ImGui.MenuItem("Quit Game"):
			get_tree().quit()
		ImGui.EndMenu()

func showScenesMenu() -> void:
	if ImGui.BeginMenu("Scenes"):
		if ImGui.MenuItem("Reload Scene"):
			GSceneAdmin.reloadScene()

		if ImGui.BeginMenu("Quick Change"):
			for scene in GSceneAdmin.sceneMap:
				if ImGui.MenuItem(scene):
					GSceneAdmin.switchScene(scene)

			ImGui.EndMenu()

		if ImGui.MenuItem("Scene Menu"):
			# TODO: Implement.
			pass

		ImGui.EndMenu()

static var showUserSettings := [false]
static var showOverlay := [true]

func showSettingsMenu() -> void:
	if showUserSettings[0]:
		# TODO: Implement.
		pass

	if showOverlay[0]:
		DebugOverlay.showOverlayWindow(showOverlay)

	if ImGui.BeginMenu("Settings"):
		if ImGui.MenuItem("User Settings"):
			showUserSettings[0] = !showUserSettings[0]

		if ImGui.MenuItem("Toggle Overlay"):
			showOverlay[0] = !showOverlay[0]
		
		ImGui.EndMenu()

static var showPlayerMenu := [false]

func showGameplayMenu() -> void:
	if showPlayerMenu[0]:
		DebugPlayerMenu.showPlayerMenuWindow(showPlayerMenu)

	if ImGui.BeginMenu("Gameplay"):
		if ImGui.MenuItem("Player Menu"):
			showPlayerMenu[0] = !showPlayerMenu[0]

		ImGui.EndMenu()

func showLevelMenu() -> void:
	if ImGui.BeginMenu("Level"):
		if ImGui.MenuItem("Difficulty"):
			# TODO: Implement.
			pass

		if ImGui.MenuItem("Ambience"):
			# TODO: Implement.
			pass

		ImGui.EndMenu()

static var showFrame := [false]
static var showMemory := [false]
static var showLogger := [false]

func showProfilingMenu() -> void:
	if showFrame[0]:
		DebugProfilers.showFrameWindow(showFrame)

	if showMemory[0]:
		DebugProfilers.showMemoryWindow(showMemory)

	if showLogger[0]:
		DebugProfilers.showLoggerWindow(showLogger)

	if ImGui.BeginMenu("Profiling"):
		if ImGui.MenuItem("Frame"):
			showFrame[0] = !showFrame[0]

		if ImGui.MenuItem("Memory"):
			showMemory[0] = !showMemory[0]

		if ImGui.MenuItem("Logger"):
			showLogger[0] = !showLogger[0]
		
		ImGui.EndMenu()
