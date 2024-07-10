class_name DebugDifficultyMenu
## Debug Menu for monitoring game difficulty.

static var set_rating := [10.0]

static func show_difficulty_menu_window(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(280, 420), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(20, 150), ImGui.Cond_Once)

	ImGui.Begin("Difficulty Menu", p_open, ImGui.WindowFlags_NoSavedSettings)
	ImGui.Text("Player Rating")
	set_rating[0] = GEntityAdmin.player.player_rating
	if ImGui.InputInt("##rating input", set_rating):
		GEntityAdmin.player.player_rating = set_rating[0]
	ImGui.End()
