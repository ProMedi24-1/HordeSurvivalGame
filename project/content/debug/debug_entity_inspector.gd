class_name DebugEntityInspector
extends DebugUiBase

var window_init: bool = false

var selected_item := [null]

func _init() -> void:
    super("DebugEntityInspector", false)

func draw_contents(_p_show: Array = [true]) -> void:
    if not window_init:
        window_init = true
        ImGui.SetNextWindowPos(Vector2(700, 100))
        ImGui.SetNextWindowSize(Vector2(300, 200))
    
    ImGui.Begin("Entity Inspector", _p_show, ImGui.WindowFlags_NoSavedSettings)

    ImGui.SeparatorText("Entities")

    ImGui.SetNextItemWidth(0)
    ImGui.ListBox("##entity_list", selected_item, EntityAdmin.entities.duplicate(), EntityAdmin.entities.size())

    if ImGui.Button("Delete Entity"):
        if not selected_item.is_empty() and EntityAdmin.entities.size() > 0:
            GameGlobals.entity_admin.delete_entity(EntityAdmin.entities[selected_item[0]])
            
    ImGui.End() 
