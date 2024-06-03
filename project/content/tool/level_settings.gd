@tool 
class_name LevelSettings
extends EditorScript

var show_gui: bool = false
var button_2d: Button

var world_env: WorldEnvironment
#@export var canvas_mod: CanvasModulate

var scene_admin = SceneAdmin.new()

func _ready() -> void:
    if Engine.is_editor_hint():
        show_gui = ImGuiGD.ToolInit()
        var title_bar := EditorInterface.get_base_control().find_child("@EditorTitleBar*", true, false)
        button_2d = title_bar.find_child("2D", true, false)

func _process(_delta: float) -> void:
    if show_gui and button_2d.button_pressed:
        ImGui.Begin("Level Settings")
        ImGui.SeparatorText("General")

        ImGui.Text("Current Level: %s" % get_scene().name)

        ImGui.SeparatorText("Ambience")

        #if SceneAdmin.scenes.has(get_scene().name):
            #ImGui.Text("contains")
        #else:
            #ImGui.Text("doesn't contain")
        #ImGui.ColorEdit3("Modulate", new_modulate)
        #if scene_admin.scenes.has(get_tree().current_scene.name):
            #ImGui.Text("contains")
        #else:
            #ImGui.Text("doesn't contain")

        #if canvas_mod:
            #canvas_mod.modulate = new_modulate[0]

        #ImGui.ColorEdit3("Ambient Color", new_modulate)
            
        #ImGui.ColorEdit3("Ambience", level_ambience)
        ImGui.End()
