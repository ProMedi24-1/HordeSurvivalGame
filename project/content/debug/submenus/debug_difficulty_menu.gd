class_name DebugDifficultyMenu
## Debug Menu for monitoring game difficulty.

static var set_rating := [10.0]
static var set_adaptive := [false]
static var set_wave_paused := [false]
static var set_time_scale := [1.0]

static func show_difficulty_menu_window(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(280, 420), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(20, 150), ImGui.Cond_Once)

	ImGui.Begin("Difficulty Menu", p_open, ImGui.WindowFlags_NoSavedSettings)

	if GEntityAdmin.player == null or GSceneAdmin.level_base == null:
		ImGui.Text("Player or LevelBase not found")
		ImGui.End()
		return

	ImGui.Text("Player Rating")
	set_rating[0] = GEntityAdmin.player.player_rating
	if ImGui.InputInt("##rating input", set_rating):
		GEntityAdmin.player.player_rating = set_rating[0]
	#ImGui.PushTextWrapPos()
	#ImGui.Text("This rating is used to determine the difficulty of the game.")
	#ImGui.PopTextWrapPos()

	set_adaptive[0] = WaveSpawner.adaptive_difficulty
	if ImGui.Checkbox("Adaptive Difficulty", set_adaptive):
		WaveSpawner.adaptive_difficulty = set_adaptive[0]

	ImGui.Text("Time elapsed: %d" % GSceneAdmin.level_base.time_elapsed)
	ImGui.SeparatorText("Waves")
	if WaveSpawner.wave_ref.wave_timer:
		ImGui.Text("Wave Time left: %d/%d" % [
			WaveSpawner.wave_ref.wave_timer.time_left, WaveSpawner.wave_duration])
	ImGui.Text("Current Wave: %d" % WaveSpawner.current_wave)
	ImGui.Text("Wave Duration: %d" % WaveSpawner.wave_duration)


	if ImGui.Button("End Wave"):
		WaveSpawner.wave_ref.end_wave()
		#var wave = Wave.new()
		#GSceneAdmin.level_base.add_child(wave)
		#wave.start_wave()

	#if ImGui.Button("Start Wave"):
		#WaveSpawner.wave_ref.start_wave()

	set_wave_paused[0] = WaveSpawner.wave_ref.wave_running
	if ImGui.Checkbox("Wave Running", set_wave_paused):
		WaveSpawner.wave_ref.wave_running = set_wave_paused[0]

	ImGui.SeparatorText("Player Performance")
	ImGui.Text("Damage Taken: %d" % GEntityAdmin.player.damage_taken)
	ImGui.Text("Kills in Wave: %d" % GEntityAdmin.player.kills_in_wave)

	ImGui.SeparatorText("Ambience")
	ImGui.Text("Ambience State: %s" % LevelBase.LevelAmbience.keys()[
								GSceneAdmin.level_base.ambience_state])
	if ImGui.Button("Non Spooky"):
		GSceneAdmin.level_base.change_ambience(LevelBase.LevelAmbience.NON_SPOOKY)

	ImGui.SameLine()
	if ImGui.Button("Half Spooky"):
		GSceneAdmin.level_base.change_ambience(LevelBase.LevelAmbience.HALF_SPOOKY)

	ImGui.SameLine()
	if ImGui.Button("Spooky"):
		GSceneAdmin.level_base.change_ambience(LevelBase.LevelAmbience.SPOOKY)

	ImGui.Text("TimeScale (Slomo - Speedup)")
	if ImGui.InputFloatEx("##timeScaleInput", set_time_scale, 0.1):
		Engine.time_scale = set_time_scale[0]

	ImGui.End()
