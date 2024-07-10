class_name DebugMenuBar extends Node
## Menu Bar for Debug-Tools using ImGUi

static var show_demo := [false]

static var show_frame := [false]
static var show_memory := [false]
static var show_logger := [false]

static var show_user_settings := [false]
static var show_overlay := [true]

static var show_player_menu := [false]

static var show_difficulty_window := [false]

func _ready() -> void:
	self.name = "DebugMenuBar"


func _process(_delta: float) -> void:
	ImGui.BeginMainMenuBar()

	show_game_menu()
	show_scenes_menu()
	show_settings_menu()
	show_gameplay_menu()
	show_level_menu()
	show_profiling_menu()

	if show_demo[0]:
		ImGui.ShowDemoWindow(show_demo)

	if ImGui.BeginMenu("Misc"):
		if ImGui.MenuItem("ImGui Demo"):
			show_demo[0] = !show_demo[0]
		ImGui.EndMenu()

	ImGui.EndMainMenuBar()


# Custom functions
func show_game_menu() -> void:
	if ImGui.BeginMenu("Game"):
		if ImGui.MenuItem("Quit Game"):
			get_tree().quit()
		ImGui.EndMenu()


func show_scenes_menu() -> void:
	if ImGui.BeginMenu("Scenes"):
		if ImGui.MenuItem("Reload Scene"):
			GSceneAdmin.reload_scene()

		if ImGui.BeginMenu("Quick Change"):
			for scene in GSceneAdmin.scene_map:
				if ImGui.MenuItem(scene):
					GSceneAdmin.switch_scene(scene)

			ImGui.EndMenu()

		if ImGui.MenuItem("Scene Menu"):
			# TODO: Implement.
			pass

		ImGui.EndMenu()


func show_settings_menu() -> void:
	if show_user_settings[0]:
		DebugUserSettings.show_user_settings_window(show_user_settings)

	if show_overlay[0]:
		DebugOverlay.show_overlay_window(show_overlay)

	if ImGui.BeginMenu("Settings"):
		if ImGui.MenuItem("User Settings"):
			show_user_settings[0] = !show_user_settings[0]

		if ImGui.MenuItem("Toggle Overlay"):
			show_overlay[0] = !show_overlay[0]

		ImGui.EndMenu()


func show_gameplay_menu() -> void:
	if show_player_menu[0]:
		DebugPlayerMenu.show_player_menu_window(show_player_menu)

	if ImGui.BeginMenu("Gameplay"):
		if ImGui.MenuItem("Player Menu"):
			show_player_menu[0] = !show_player_menu[0]

		ImGui.EndMenu()


func show_level_menu() -> void:
	if show_difficulty_window[0]:
		DebugDifficultyMenu.show_difficulty_menu_window(show_difficulty_window)

	if ImGui.BeginMenu("Level"):
		if ImGui.MenuItem("Difficulty"):
			show_difficulty_window[0] = !show_difficulty_window[0]

		if ImGui.MenuItem("Ambience"):
			# TODO: Implement.
			pass

		ImGui.EndMenu()


func show_profiling_menu() -> void:
	if show_frame[0]:
		DebugProfilers.show_frame_window(show_frame)

	if show_memory[0]:
		DebugProfilers.show_memory_window(show_memory)

	if show_logger[0]:
		DebugProfilers.show_logger_window(show_logger)

	if ImGui.BeginMenu("Profiling"):
		if ImGui.MenuItem("Frame"):
			show_frame[0] = !show_frame[0]

		if ImGui.MenuItem("Memory"):
			show_memory[0] = !show_memory[0]

		if ImGui.MenuItem("Logger"):
			show_logger[0] = !show_logger[0]

		ImGui.EndMenu()
