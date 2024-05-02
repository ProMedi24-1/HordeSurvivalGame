class_name DevMenuBase

var init_window: bool = true
var show_window: bool = false

var window_size: Vector2
var window_position: Vector2

var window_title: String

func _init(_window_title: String, _window_size: Vector2, _window_position: Vector2) -> void:
    show_window = true
    window_size = _window_size
    window_position = _window_position
    window_title = _window_title

func toggle_visibility() -> void:
    show_window = !show_window

func draw_window() -> void:
    if show_window:
        ImGui.Begin(window_title)
        if init_window:
            ImGui.SetWindowSize(window_size)
            ImGui.SetWindowPos(window_position)
            init_window = false
                
        draw_contents()
        ImGui.End()
       
# Override 
func draw_contents() -> void:
    pass
