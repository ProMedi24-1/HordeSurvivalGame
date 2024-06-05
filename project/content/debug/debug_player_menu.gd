class_name DebugPlayerMenu
extends DebugUiBase

var window_init: bool = false

var set_god_mode := [false]
var set_health := [50]
var set_heal := [25]
var set_damage := [10]

func _init() -> void:
	super("PlayerMenu", false)

func draw_contents(_p_show: Array = [true]) -> void:
	if not window_init:
		window_init = true
		ImGui.SetNextWindowPos(Vector2(800, 100))
		ImGui.SetNextWindowSize(Vector2(300, 200))
	
	ImGui.Begin("Player Menu", _p_show, ImGui.WindowFlags_NoSavedSettings)
	
	if GameGlobals.entity_admin.player == null:
		ImGui.Text("No Player exists...")
		ImGui.End()
		return

	ImGui.SeparatorText("Stats")
	var player = GameGlobals.entity_admin.player
	var health = player.stats_component.health#GameGlobals.entity_admin.player.stats_component.health
	var max_health = player.stats_component.max_health#GameGlobals.entity_admin.player.stats_component.max_health

	if ImGui.TreeNode("Health"):
		ImGui.TextColored(Color.GREEN,"Health: %d/%d" % [health, max_health])

		ImGui.Text("Is Full Health: %s" % GameGlobals.entity_admin.player.health_component.is_full_health())
		ImGui.Text("Is Low Health: %s" % GameGlobals.entity_admin.player.health_component.is_low_health())
		ImGui.TreePop()

	if ImGui.CollapsingHeader("Tools"):
		if ImGui.TreeNode("Health##2"):
			if ImGui.Checkbox("God Mode", set_god_mode):
				pass

			ImGui.Text("Set Health")
			ImGui.InputInt("##Health", set_health)
			ImGui.SameLine()
			if ImGui.Button("Set##1"):
				player.health_component.set_health(set_health[0])
			
			ImGui.Text("Heal Amount")
			ImGui.InputInt("##Heal", set_heal)
			ImGui.SameLine()
			if ImGui.Button("Heal##1"):
				player.health_component.take_heal(set_heal[0])

			ImGui.Text("Damage Amount")
			ImGui.InputInt("##Damage", set_damage)
			ImGui.SameLine()
			if ImGui.Button("Damage##1"):
				player.health_component.take_damage(set_damage[0])

			ImGui.TreePop()

	ImGui.End()
