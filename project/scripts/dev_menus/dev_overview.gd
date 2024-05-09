class_name DevOverview
extends DevMenuBase


var ProfilerMenu := DevProfiler.new()
var StatisticsMenu := DevStatistics.new()
var PlayerMenu := DevPlayer.new()
var EnemyMenu
var GameStateMenu
var SettingsMenu

var show_profiler := [false]
var show_statistics := [false]

var show_player_menu := [false]
var show_enemy_menu := [false]

var show_gamestate_menu := [false]
var show_settings_menu := [false]

var show_demo := [false]

func _init() -> void:
    super("Dev-Menu Overview", Vector2(300, 350), Vector2(50, 50))

func draw_contents() -> void:
    ImGui.SeparatorText("Tools and Menus here:")
    
    if ImGui.CollapsingHeader("Performance & Profiling"):
            ImGui.Checkbox("Show Profiler", show_profiler)
            ImGui.SameLine()
            ImGui.Checkbox("Show Statistics", show_statistics)
            
    if ImGui.CollapsingHeader("Player & Enemies"):
        ImGui.Checkbox("Show Player Menu", show_player_menu)
        ImGui.Checkbox("Show Enemy Menu", show_enemy_menu)
        
    if ImGui.CollapsingHeader("Game & Settings"):
        ImGui.Checkbox("Show GameState Menu", show_gamestate_menu)
        ImGui.Checkbox("Show Settings Menu", show_settings_menu)
        
    if ImGui.CollapsingHeader("Misc."):
        ImGui.Checkbox("Show ImGui-Demo", show_demo)
        
    ImGui.SeparatorText("Running on:")
    ImGui.Text("Platform: %s" % OS.get_name())
    ImGui.Text("Locale: %s" % OS.get_locale())
    ImGui.Text("Lang: %s" % OS.get_locale_language())
    
    ImGui.Separator()
    ImGui.Text("Debug-Build: %s" % OS.is_debug_build())
    ImGui.Text("Using ImGui: %s" % ImGui.GetVersion())
    var mouse_pos := ImGui.GetMousePos()
    ImGui.Text("Mouse pos: (%d, %d)" % [mouse_pos.x, mouse_pos.y])
    
    draw_new_windows()
    
func draw_new_windows():
    if show_demo[0]:
        ImGui.ShowDemoWindow()
    if show_profiler[0]:
        ProfilerMenu.draw_window()
    if show_statistics[0]:
        StatisticsMenu.draw_window()
    if show_player_menu[0]:
        PlayerMenu.draw_window()
  

    pass
