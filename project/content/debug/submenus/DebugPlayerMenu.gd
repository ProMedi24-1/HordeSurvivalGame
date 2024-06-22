class_name DebugPlayerMenu
extends Object

static var showPos := false
static var showVelocity := false

static var setHealth := [0]
static var setMaxHealth := [200]
static var setGodMode := [false]

static var damageInput := [25]
static var healInput := [25]

static var setMovSpeed := [0.0]

static func showPlayerMenuWindow(p_open: Array) -> void:
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

	const tableFlags := ImGui.TableFlags_Borders
	if ImGui.BeginTable("infoTable", 2, tableFlags):

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		showPos = ImGui.TreeNodeEx("Position: ", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		if showPos:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Position X: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.movBody.global_position.x)

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Position Y: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.movBody.global_position.y)
			ImGui.TreePop()

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		showVelocity = ImGui.TreeNodeEx("Velocity: ", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		if showVelocity:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Velocity X: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.movBody.velocity.x)

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text(" Velocity Y: ")
			ImGui.TableNextColumn()
			ImGui.Text(" %d " % player.movBody.velocity.y)
			ImGui.TreePop()

		ImGui.EndTable()

	ImGui.Text("")
	ImGui.Separator()

	if ImGui.BeginTabBar("##Tabs", ImGui.TabBarFlags_None):

		if ImGui.BeginTabItem("General"):
			drawGeneralTab()
			ImGui.EndTabItem()

		if ImGui.BeginTabItem("Progress"):
			drawProgressTab()
			ImGui.EndTabItem()
		
		if ImGui.BeginTabItem("Weapons"):

			ImGui.EndTabItem()

		if ImGui.BeginTabItem("Stats"):
			drawStatsTab()
			ImGui.EndTabItem()

		ImGui.EndTabBar()
	ImGui.End()

static func drawGeneralTab() -> void:
	var player := GEntityAdmin.player
	ImGui.SeparatorText("Health")
	ImGui.TextColored(Color.GREEN, "Health: [%d/%d]" % [player.health, player.maxHealth])
	ImGui.SameLine()
	ImGui.Text("HealthState: %s" % player.HealthStatus.keys()[player.healthStatus])

	@warning_ignore("integer_division")
	var bar: float = float(player.health) / float(player.maxHealth)
	ImGui.ProgressBar(bar, Vector2( - 1, 15))

	setHealth[0] = player.health
	if ImGui.SliderInt("Set Health", setHealth, 0, player.maxHealth):
		player.setHealth(setHealth[0])

	ImGui.Text("Max Health:")
	ImGui.InputInt("##maxHealthInput", setMaxHealth)
	ImGui.SameLine()
	if ImGui.Button("Set##maxHealth"):
		player.setMaxHealth(setMaxHealth[0])

	setGodMode[0] = player.godMode
	if ImGui.Checkbox("God Mode", setGodMode):
		player.godMode = setGodMode[0]

	if ImGui.TreeNode("Actions"):

		ImGui.SetNextItemWidth(100)
		ImGui.InputInt("##damageInput", damageInput)
		ImGui.SameLine()
		if ImGui.Button("Damage"):
			player.takeDamage(damageInput[0])

		ImGui.SetNextItemWidth(100)
		ImGui.InputInt("##healInput", healInput)
		ImGui.SameLine()
		if ImGui.Button("Heal"):
			player.takeHeal(healInput[0])

		ImGui.TreePop()

	ImGui.SeparatorText("Movement")

	setMovSpeed[0] = player.movSpeed

	ImGui.Text("Movement Speed:")
	ImGui.SetNextItemWidth(250)
	if ImGui.DragFloatEx("##Set Movement Speed1", setMovSpeed, 50, 0.0, 25000.0):
		player.movSpeed = setMovSpeed[0]

static func drawStatsTab() -> void:
	var player := GEntityAdmin.player
	var level := GSceneAdmin.levelBase
	const tableFlags := ImGui.TableFlags_Borders|ImGui.TableFlags_RowBg
	if ImGui.BeginTable("statsTable", 2, tableFlags):

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("maxHealth:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.maxHealth))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("health:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.health))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("healthStatus:")
		ImGui.TableNextColumn()
		ImGui.Text(player.HealthStatus.keys()[player.healthStatus])

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("godMode:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.godMode))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("movSpeed:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.movSpeed))

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
		ImGui.Text(str(player.levelProgress))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("levelRequired:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.levelRequired))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("levelReqMultiplier:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.levelReqMultiplier))

		ImGui.EndTable()

	if ImGui.BeginTable("levelTable", 2, tableFlags):

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("timeSurvived:")
		ImGui.TableNextColumn()
		ImGui.Text(str(level.timeElapsed))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("kills:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.kills))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("damageTaken:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.damageTaken))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("healTaken:")
		ImGui.TableNextColumn()
		ImGui.Text(str(player.healTaken))

		ImGui.EndTable()

static var addCrystals := [10]
static var setProgress := [0]
static var setLevel := [5]
static var setReqMult := [1.5]

static func drawProgressTab() -> void:
	var player := GEntityAdmin.player

	ImGui.SeparatorText("Level")

	ImGui.TextColored(Color.AQUAMARINE, "Level: %d" % player.level)
	ImGui.SameLine()
	ImGui.TextColored(Color.AQUAMARINE, "[%d/%d]" % [player.levelProgress, player.levelRequired])
	ImGui.SameLine()
	ImGui.Text("nextReqMult: %.2f" % player.levelReqMultiplier)

	var bar: float = float(player.levelProgress) / float(player.levelRequired)
	ImGui.ProgressBar(bar, Vector2( - 1, 15))

	setProgress[0] = player.levelProgress
	if ImGui.SliderInt("Progress##slider", setProgress, 0, player.levelRequired):
		player.levelProgress = setProgress[0]

	if ImGui.InputInt("Set Level##levelInput", setLevel):
		player.level = setLevel[0]
		player.updateLevelReq()

	setReqMult[0] = player.levelReqMultiplier
	if ImGui.InputFloat("Set ReqMult##reqMultInput", setReqMult):
		player.levelReqMultiplier = setReqMult[0]
		player.updateLevelReq()

	if ImGui.TreeNode("Actions##2"):

		ImGui.SetNextItemWidth(100)
		ImGui.InputInt("##crystalInput", addCrystals)
		ImGui.SameLine()
		if ImGui.Button("Add Crystals"):
			player.addCrystal(addCrystals[0])

		if ImGui.Button("Reset Level"):
			player.level = 0
			player.levelProgress = 0
			player.updateLevelReq()
			#player.levelRequired = 25

		if ImGui.Button("Reset Crystals"):
			player.crystals = 0

		ImGui.TreePop()

	ImGui.Separator()
