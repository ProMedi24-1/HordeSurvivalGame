class_name DebugLogger
extends DebugUiBase

var window_init: bool = false
var auto_scroll := [true]

var log_buffer: Array = []

func _init() -> void:
    super("Logger", false)

func _ready() -> void:
    GameGlobals.logger.connect("logged", on_logged)

func draw_contents(_p_show: Array = [true]) -> void:
    if not window_init:
        window_init = true
        ImGui.SetNextWindowPos(Vector2(500, 100))
        ImGui.SetNextWindowSize(Vector2(300, 300))

    ImGui.Begin("Logger", _p_show, ImGui.WindowFlags_NoSavedSettings)
    
    if ImGui.Button("Clear Log"):
        clear_log()

    ImGui.SameLine()
    ImGui.Checkbox("Scroll to Bottom", auto_scroll)

    ImGui.Separator()

    if ImGui.BeginChild("ScrollingRegion", Vector2(0, 0), false, 0):
        ImGui.PushTextWrapPos()
        
        for message in log_buffer:
            ImGui.TextColored(message.get_first(), message.get_second())

        ImGui.PopTextWrapPos()

        if auto_scroll[0]:
            ImGui.SetScrollHereY(1.0)

        ImGui.EndChild()
    ImGui.End()
    

func on_logged(message: String, color: Color) -> void:
    log_buffer.append(Pair.new(color, message))

func clear_log() -> void:
    log_buffer.clear()