extends DevMenuBase
class_name DevProfiler

const B_TO_MB = 1024 * 1024
const DATA_RATE: int = 10 # data poll per X frames

var frame_counter: int = DATA_RATE
var perf_data: Dictionary = {}

func _init() -> void:
    super("Profiler", Vector2(200, 200), Vector2(800, 50))

func poll_data() -> void:
    frame_counter += 1
    
    if frame_counter >= DATA_RATE:
        fill_data()
        frame_counter = 0

func fill_data() -> void:
    perf_data["FPS"] = Performance.get_monitor(Performance.TIME_FPS)
    perf_data["Frametime"] = Performance.get_monitor(Performance.TIME_PROCESS) * 1000
    
    perf_data["Draw Calls"] = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
    perf_data["Objects Frame"] = Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME)
    perf_data["Primitives Frame"] = Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME)
    perf_data["Video Memory"] = Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / B_TO_MB
    perf_data["Texture Memory"] = Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED) / B_TO_MB
    perf_data["Buffer Memory"] = Performance.get_monitor(Performance.RENDER_BUFFER_MEM_USED) / B_TO_MB

func draw_contents() -> void:
    poll_data()
    
    ImGui.Text("FPS: %s" % perf_data["FPS"])
    ImGui.SetItemTooltip("Number of frames rendered in the last second.")
    
    ImGui.Text("Frametime: %.2f ms" % perf_data["Frametime"])
    ImGui.SetItemTooltip("Time it took to complete one frame, in seconds.")
    
    ImGui.Separator()
    
    ImGui.Text("Draw Calls: %s" % perf_data["Draw Calls"])
    ImGui.SetItemTooltip("Number of draw calls in the last rendered frame. This metric doesn't include culled objects.")
    
    ImGui.Text("Objects: %s" % perf_data["Objects Frame"])
    ImGui.SetItemTooltip("Total number of objects in the last rendered frame. This metric doesn't include culled objects.")
    
    ImGui.Text("Primitives: %s" % perf_data["Primitives Frame"])
    ImGui.SetItemTooltip("Total number of vertices or indices rendered in the last rendered frame. This metric doesn't include primitives from culled objects.")

    ImGui.SeparatorText("Memory Usage")
    ImGui.Text("Video Memory: %.2f mb" % perf_data["Video Memory"])
    ImGui.SetItemTooltip("Amount of video memory used (texture and vertex memory combined)")

    ImGui.Text("Texture Memory: %.2f mb" % perf_data["Texture Memory"])
    ImGui.SetItemTooltip("Amount of texture memory used.")

    ImGui.Text("Buffer Memory: %.2f mb" % perf_data["Buffer Memory"])
    ImGui.SetItemTooltip("Amount of render buffer memory used.")
