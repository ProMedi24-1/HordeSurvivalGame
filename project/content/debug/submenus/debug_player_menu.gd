class_name DebugPlayerMenu
## ImGui Player Menu with Cheats to test player behaviour.

static var show_pos := false
static var show_velocity := false
static var set_health := [0]
static var set_max_health := [200]
static var set_god_mode := [false]
static var damage_input := [25]
static var heal_input := [25]
static var set_mov_speed := [0.0]

static var add_crystals := [10]
static var set_progress := [0]
static var set_level := [5]
static var set_req_mult := [1.5]


static func show_player_menu_window(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(280, 420), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(20, 150), ImGui.Cond_Once)

	if GEntityAdmin.player == null:
		ImGui.Begin("Player Menu", p_open, ImGui.WindowFlags_NoSavedSettings)
		ImGui.PushTextWrapPos()
		ImGui.Text("No Player Entity registered, are you in a level?")
		ImGui.PopTextWrapPos()
		ImGui.End()
		return

	var player := GEntityAdmin.player

	ImGui.Begin("Player Menu", p_open, ImGui.WindowFlags_NoSavedSettings)

	const TABLE_FLAGS := ImGui.TableFlags_Borders
	if ImGui.BeginTable("infoTable", 2, TABLE_FLAGS):
		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		show_pos = ImGui.TreeNodeEx("Position: ", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		if show_pos:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Position X: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.mov_body.global_position.x)

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Position Y: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.mov_body.global_position.y)
			ImGui.TreePop()

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		show_velocity = ImGui.TreeNodeEx("Velocity: ", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		if show_velocity:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Velocity X: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.mov_body.velocity.x)

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Velocity Y: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.mov_body.velocity.y)
			ImGui.TreePop()

		ImGui.EndTable()

	ImGui.Text("")
	ImGui.Separator()

	if ImGui.BeginTabBar("##Tabs", ImGui.TabBarFlags_None):
		if ImGui.BeginTabItem("General"):
			draw_general_tab()
			ImGui.EndTabItem()

		if ImGui.BeginTabItem("Progress"):
			draw_progress_tab()
			ImGui.EndTabItem()

		if ImGui.BeginTabItem("Weapons"):
			draw_weapons_tab()
			ImGui.EndTabItem()

		#if ImGui.BeginTabItem("Stats"):
			#draw_stats_tab()
			#ImGui.EndTabItem()

		ImGui.EndTabBar()
	ImGui.End()


static func draw_general_tab() -> void:
	var player := GEntityAdmin.player
	ImGui.SeparatorText("Health")
	ImGui.TextColored(Color.GREEN, "Health: [%d/%d]" % [player.health, player.max_health])
	ImGui.SameLine()
	ImGui.Text("HealthState: %s" % player.HealthStatus.keys()[player.health_status])

	@warning_ignore("integer_division")
	var bar: float = float(player.health) / float(player.max_health)
	ImGui.ProgressBar(bar, Vector2(-1, 15))

	set_health[0] = player.health
	if ImGui.SliderInt("Set Health", set_health, 0, player.max_health):
		player.set_health(set_health[0])

	ImGui.Text("Max Health:")
	ImGui.InputInt("##maxHealthInput", set_max_health)
	ImGui.SameLine()
	if ImGui.Button("Set##maxHealth"):
		player.set_max_health(set_max_health[0])

	set_god_mode[0] = player.god_mode
	if ImGui.Checkbox("God Mode", set_god_mode):
		player.god_mode = set_god_mode[0]

	if ImGui.TreeNode("Actions"):
		ImGui.SetNextItemWidth(100)
		ImGui.InputInt("##damage_input", damage_input)
		ImGui.SameLine()
		if ImGui.Button("Damage"):
			player.take_damage(damage_input[0])

		ImGui.SetNextItemWidth(100)
		ImGui.InputInt("##heal_input", heal_input)
		ImGui.SameLine()
		if ImGui.Button("Heal"):
			player.take_heal(heal_input[0])

		ImGui.TreePop()

	ImGui.SeparatorText("Movement")

	set_mov_speed[0] = player.mov_speed

	ImGui.Text("Movement Speed:")
	ImGui.SetNextItemWidth(250)
	if ImGui.DragFloatEx("##Set Movement Speed1", set_mov_speed, 50, 0.0, 25000.0):
		player.mov_speed = set_mov_speed[0]


static func draw_weapons_tab() -> void:
	var player := GEntityAdmin.player
	#ImGui.SeparatorText("Weapons")
	ImGui.Text("Add Weapons")

	for i in WeaponUtils.WeaponType.size():
		if ImGui.Button("Add %s" % WeaponUtils.WeaponType.keys()[i]):
			WeaponUtils.add_weapon_to_player(i)


	ImGui.SeparatorText("Inventory")
	if ImGui.BeginChild("ScrollingRegion", Vector2(0, 0), false):
		for i in player.weapon_inventory.size():
			var weapon := player.weapon_inventory[i]
			if weapon == null:
				continue

			ImGui.Text("Weapon: %s" % weapon.weapon_name)
			ImGui.Text("Slot: %d" % weapon.weapon_slot)
			ImGui.Text("Level: %d" % weapon.level)
			ImGui.Text("Progress: %d" % weapon.level_progress)
			ImGui.Text("Required: %d" % weapon.level_required)
			ImGui.Text("Damage: %d" % weapon.damage)
			ImGui.Text("Cooldown: %.2f" % weapon.cooldown_time)

			#ImGui::PushID(i)
			ImGui.PushID("LevelUp" + str(i))
			if ImGui.Button("Level Up"):
				weapon.level_up()
			ImGui.PopID()

			ImGui.SameLine()
				#if ImGui.Button("Attack"):
					#weapon.attack()

			ImGui.PushID("Attack" + str(i))
			if ImGui.Button("Attack"):
				weapon.attack()
			ImGui.PopID()

			ImGui.SameLine()

			ImGui.PushID("Discard" + str(i))
			if ImGui.Button("Discard"):
				WeaponUtils.discard_weapon_from_player(weapon.weapon_slot - 1)
			ImGui.PopID()


			ImGui.Separator()
		ImGui.EndChild()

static func draw_stats_tab() -> void:
	var player := GEntityAdmin.player
	var level := GSceneAdmin.level_base
	const TABLE_FLAGS := ImGui.TableFlags_Borders | ImGui.TableFlags_RowBg

	if ImGui.BeginTable("statsTable", 2, TABLE_FLAGS):
		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("maxHealth:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.max_health))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("health:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.health))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("healthStatus:")
		ImGui.TableNextColumn()
		ImGui.Text(player.HealthStatus.keys()[player.health_status])

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("godMode:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.god_mode))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("movSpeed:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.mov_speed))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("level:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.level))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("crystals:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.crystals))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("levelProgress:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.level_progress))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("levelRequired:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.level_required))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("levelReqMultiplier:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.level_req_multiplier))

		ImGui.EndTable()

	if ImGui.BeginTable("levelTable", 2, TABLE_FLAGS):
		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("timeSurvived:")
		ImGui.TableNextColumn()
		ImGui.Text(str(level.time_elapsed))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("kills:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.kills))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("damageTaken:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.damage_taken))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("healTaken:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.heal_taken))

		ImGui.EndTable()


static func draw_progress_tab() -> void:
	var player := GEntityAdmin.player

	ImGui.SeparatorText("Level")

	ImGui.TextColored(Color.AQUAMARINE, "Level: %d" % player.level)
	ImGui.SameLine()
	ImGui.TextColored(Color.AQUAMARINE, "[%d/%d]" % [player.level_progress, player.level_required])
	ImGui.SameLine()
	ImGui.Text("nextReqMult: %.2f" % player.level_req_multiplier)

	var bar: float = float(player.level_progress) / float(player.level_required)
	ImGui.ProgressBar(bar, Vector2(-1, 15))

	set_progress[0] = player.level_progress
	if ImGui.SliderInt("Progress##slider", set_progress, 0, player.level_required):
		player.level_progress = set_progress[0]

	if ImGui.InputInt("Set Level##levelInput", set_level):
		player.level = set_level[0]
		player.update_level_req()

	set_req_mult[0] = player.level_req_multiplier
	if ImGui.InputFloat("Set ReqMult##reqMultInput", set_req_mult):
		player.level_req_multiplier = set_req_mult[0]
		player.update_level_req()

	if ImGui.TreeNode("Actions##2"):
		ImGui.SetNextItemWidth(100)
		ImGui.InputInt("##crystalInput", add_crystals)
		ImGui.SameLine()
		if ImGui.Button("Add Crystals"):
			player.add_crystal(add_crystals[0])

		if ImGui.Button("Reset Level"):
			player.level = 0
			player.level_progress = 0
			player.update_level_req()
			#player.levelRequired = 25

		if ImGui.Button("Reset Crystals"):
			player.crystals = 0

		ImGui.TreePop()

	ImGui.Separator()
