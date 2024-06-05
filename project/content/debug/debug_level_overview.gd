class_name DebugLevelOverview
extends DebugUiBase

var window_init: bool = false

var time_scale := [1.0]
var is_static := [false]
var adaptive := [false]
var hold := [false]
var set_difficulty := []
var set_time := []
var set_max_time := []

var difficulty_history := []

func _init() -> void:
	super("LevelOverview", false)

func _ready() -> void:
	if SceneAdmin.level_component != null:
		adaptive  = [SceneAdmin.level_component.is_adaptive]
		#set_max_time = [SceneAdmin.level_component.max_time]

func draw_contents(_p_show: Array = [true]) -> void:
	if not window_init:
		window_init = true
		ImGui.SetNextWindowPos(Vector2(700, 100))
		ImGui.SetNextWindowSize(Vector2(300, 200))
	
	ImGui.Begin("Level Overview", _p_show, ImGui.WindowFlags_NoSavedSettings)

	ImGui.TextColored(Color.DODGER_BLUE,"Current Level: " + SceneAdmin.scene_root.name)

	ImGui.SeparatorText("Time")
	if StateAdmin.game_state != StateAdmin.GameState.PLAYING:
		ImGui.Text("Not in a level. Nothing to show...")
		draw_tools()
		ImGui.End() 
		return
	
	var time_elapsed = SceneAdmin.level_component.time_elapsed
	var max_time = SceneAdmin.level_component.max_time
	ImGui.TextColored(Color.AQUA,"Elapsed Time: %ds" % time_elapsed)
	ImGui.TextColored(Color.AQUA,"Formatted: %s/%s " % [SceneAdmin.level_component.get_time_string(time_elapsed),
									 SceneAdmin.level_component.get_time_string(max_time)])
	if ImGui.Checkbox("Hold", hold):
		SceneAdmin.level_component.hold = hold[0]

	if StateAdmin.game_paused:
		ImGui.TextColored(Color.YELLOW, "GAME PAUSED")

	ImGui.SeparatorText("Difficulty")
	ImGui.TextColored(Color.ORANGE,"Difficulty: %.1f/%d" % [SceneAdmin.level_component.difficulty, 
									 SceneAdmin.level_component.max_difficulty])
	if SceneAdmin.level_component.decouple_time:
		ImGui.TextColored(Color.YELLOW, "Difficulty decoupled from time")
  
	if ImGui.Checkbox("Static", is_static):
		SceneAdmin.level_component.is_adaptive = is_static[0]

	ImGui.Separator()
	if ImGui.Checkbox("Adaptive", adaptive):
		SceneAdmin.level_component.is_adaptive = adaptive[0]

	if ImGui.TreeNode("Adaptive Only"):
		ImGui.BulletText("Estimated Player Skill: ")
		ImGui.TreePop()

	draw_tools()
	
	
	ImGui.End()
   
func draw_tools() -> void:
	if ImGui.CollapsingHeader("Tools"):
		
		if SceneAdmin.level_component != null:
		  

			if ImGui.TreeNode("Time"):
				ImGui.Text("Set Max Time(seconds)")
				ImGui.InputInt("##Max Time", set_max_time)
				ImGui.SameLine()
				if ImGui.Button("Set##1"):
					SceneAdmin.level_component.max_time = set_max_time[0]

				ImGui.Text("Set Elapsed Time(seconds)")
				#ImGui.SetNextItemWidth(-1)
				if ImGui.SliderFloat("##Time", set_time, 0.0, SceneAdmin.level_component.max_time):
					SceneAdmin.level_component.time_elapsed = set_time[0]

				ImGui.TreePop()

			if ImGui.TreeNode("Difficulty"):
				ImGui.Text("Set Difficulty(0 Easy-100 Hard)")
				if ImGui.SliderFloat("##Difficulty", set_difficulty, 0.0, 100.0):
					SceneAdmin.level_component.difficulty = set_difficulty[0]
					SceneAdmin.level_component.decouple_time = true
				ImGui.SameLine()
				if ImGui.Button("Reset##1"):
					SceneAdmin.level_component.decouple_time = false
					#set_difficulty[0] = SceneAdmin.level_component.difficulty
				if ImGui.Button("End Wave"):
					GameGlobals.logger.log("Ending Wave", Color.ORANGE)

				ImGui.TreePop()

		ImGui.Separator()
		ImGui.Text("Time Scale(Slomo, Speedup)")
		if ImGui.DragFloatEx("##Time Scale", time_scale, 0.05):
			Engine.time_scale = time_scale[0]
		ImGui.SameLine()
		if ImGui.Button("Reset##2"):
			#print("reset")
			time_scale[0] = 1.0
			Engine.time_scale = time_scale[0]

		ImGui.Text("Restart Level:")
		ImGui.SameLine()
		if ImGui.Button("Restart"):
			GameGlobals.scene_admin.switch_scene(SceneAdmin.scene_root.name, true)

			
	
