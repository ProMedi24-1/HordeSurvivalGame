class_name DebugProfiler
extends DebugUiBase

const B_TO_MB = 1024 * 1024
const DATA_RATE: int = 10

var frame_counter: int = DATA_RATE
var perf_data: Dictionary = {}

func _init() -> void:
    super("DebugProfiler", false)

func poll_data() -> void:
    frame_counter += 1
    
    if frame_counter >= DATA_RATE:
        fill_data()
        frame_counter = 0

func fill_data() -> void:
    perf_data["Draw Calls"] = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
    perf_data["Objects Frame"] = Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME)
    perf_data["Primitives Frame"] = Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME)
    perf_data["Video Memory"] = Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / B_TO_MB
    perf_data["Texture Memory"] = Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED) / B_TO_MB
    perf_data["Buffer Memory"] = Performance.get_monitor(Performance.RENDER_BUFFER_MEM_USED) / B_TO_MB

    perf_data["Memory Static"] = Performance.get_monitor(Performance.MEMORY_STATIC) / B_TO_MB
    perf_data["Memory Max"] = Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / B_TO_MB

    perf_data["Object Count"] = Performance.get_monitor(Performance.OBJECT_COUNT)
    perf_data["Object Resource"] = Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT)
    perf_data["Object Node"] = Performance.get_monitor(Performance.OBJECT_NODE_COUNT)
    perf_data["Object Orphan"] = Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)

    perf_data["Frametime Physics"] = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000

    perf_data["2D Active Objects"] = Performance.get_monitor(Performance.PHYSICS_2D_ACTIVE_OBJECTS)
    perf_data["2D Collision Pairs"] = Performance.get_monitor(Performance.PHYSICS_2D_COLLISION_PAIRS)
    perf_data["2D Islands"] = Performance.get_monitor(Performance.PHYSICS_2D_ISLAND_COUNT)

    perf_data["3D Active Objects"] = Performance.get_monitor(Performance.PHYSICS_3D_ACTIVE_OBJECTS)
    perf_data["3D Collision Pairs"] = Performance.get_monitor(Performance.PHYSICS_3D_COLLISION_PAIRS)
    perf_data["3D Islands"] = Performance.get_monitor(Performance.PHYSICS_3D_ISLAND_COUNT)


func draw_contents(_p_show: Array = [true]) -> void:
    poll_data()

    ImGui.Begin("Profiler", _p_show, ImGui.WindowFlags_NoSavedSettings)

    ImGui.SeparatorText("General")
    ImGui.Text("Draw Calls: %s" % perf_data["Draw Calls"])
    ImGui.Text("Objects: %s" % perf_data["Objects Frame"])
    ImGui.Text("Primitives: %s" % perf_data["Primitives Frame"])

    ImGui.SeparatorText("Memory Usage")
    ImGui.Text("Video Memory: %.2f mb" % perf_data["Video Memory"])
    ImGui.Text("Texture Memory: %.2f mb" % perf_data["Texture Memory"])
    ImGui.Text("Buffer Memory: %.2f mb" % perf_data["Buffer Memory"])
   
    ImGui.Separator()
    ImGui.Text("Memory Static: %.2f mb" % perf_data["Memory Static"])
    ImGui.Text("Memory Max: %.2f mb" % perf_data["Memory Max"])

    if ImGui.CollapsingHeader("Objects"):
        ImGui.Text("Object Count: %s" % perf_data["Object Count"])
        ImGui.Text("Object Resource: %s" % perf_data["Object Resource"])
        ImGui.Text("Object Node: %s" % perf_data["Object Node"])
        ImGui.Text("Object Orphan: %s" % perf_data["Object Orphan"])
    
    if ImGui.CollapsingHeader("Physics"):
        ImGui.Text("Physics Frametime: %.2f ms" % perf_data["Frametime Physics"])

        ImGui.SeparatorText("2D Physics")
        ImGui.Text("2D Active Objects: %s" % perf_data["2D Active Objects"])
        ImGui.Text("2D Collision Pairs: %s" % perf_data["2D Collision Pairs"])
        ImGui.Text("2D Islands: %s" % perf_data["2D Islands"])

        ImGui.SeparatorText("3D Physics")
        ImGui.Text("3D Active Objects: %s" % perf_data["3D Active Objects"])
        ImGui.Text("3D Collision Pairs: %s" % perf_data["3D Collision Pairs"])
        ImGui.Text("3D Islands: %s" % perf_data["3D Islands"])


    ImGui.End()
