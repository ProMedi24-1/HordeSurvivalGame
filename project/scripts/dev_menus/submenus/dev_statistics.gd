extends DevMenuBase
class_name DevStatistics

const B_TO_MB = 1024 * 1024
const DATA_RATE: int = 100 # data poll per X frames

var frame_counter: int = DATA_RATE
var stat_data: Dictionary = {}

func _init() -> void:
    super("Statistics", Vector2(200, 300), Vector2(800, 300))

func poll_data() -> void:
    frame_counter += 1
    
    if frame_counter >= DATA_RATE:
        fill_data()
        frame_counter = 0
 
func fill_data() -> void:
    stat_data["Memory Static"] = Performance.get_monitor(Performance.MEMORY_STATIC) / B_TO_MB
    stat_data["Memory Max"] = Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / B_TO_MB

    stat_data["Object Count"] = Performance.get_monitor(Performance.OBJECT_COUNT)
    stat_data["Object Resource"] = Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT)
    stat_data["Object Node"] = Performance.get_monitor(Performance.OBJECT_NODE_COUNT)
    stat_data["Object Orphan"] = Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)

    stat_data["Frametime Physics"] = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000

    stat_data["2D Active Objects"] = Performance.get_monitor(Performance.PHYSICS_2D_ACTIVE_OBJECTS)
    stat_data["2D Collision Pairs"] = Performance.get_monitor(Performance.PHYSICS_2D_COLLISION_PAIRS)
    stat_data["2D Islands"] = Performance.get_monitor(Performance.PHYSICS_2D_ISLAND_COUNT)

    stat_data["3D Active Objects"] = Performance.get_monitor(Performance.PHYSICS_3D_ACTIVE_OBJECTS)
    stat_data["3D Collision Pairs"] = Performance.get_monitor(Performance.PHYSICS_3D_COLLISION_PAIRS)
    stat_data["3D Islands"] = Performance.get_monitor(Performance.PHYSICS_3D_ISLAND_COUNT)

func draw_contents() -> void:
    poll_data()

    ImGui.Text("Memory Static: %.2f mb" % stat_data["Memory Static"])
    ImGui.Text("Memory Max: %.2f mb" % stat_data["Memory Max"])

    if ImGui.CollapsingHeader("Objects"):
        ImGui.Text("Object Count: %s" % stat_data["Object Count"])
        ImGui.Text("Object Resource: %s" % stat_data["Object Resource"])
        ImGui.Text("Object Node: %s" % stat_data["Object Node"])
        ImGui.Text("Object Orphan: %s" % stat_data["Object Orphan"])
    
    if ImGui.CollapsingHeader("Physics"):
        ImGui.Text("Physics Frametime: %.2f ms" % stat_data["Frametime Physics"])

        ImGui.SeparatorText("2D Physics")
        ImGui.Text("2D Active Objects: %s" % stat_data["2D Active Objects"])
        ImGui.Text("2D Collision Pairs: %s" % stat_data["2D Collision Pairs"])
        ImGui.Text("2D Islands: %s" % stat_data["2D Islands"])

        ImGui.SeparatorText("3D Physics")
        ImGui.Text("3D Active Objects: %s" % stat_data["3D Active Objects"])
        ImGui.Text("3D Collision Pairs: %s" % stat_data["3D Collision Pairs"])
        ImGui.Text("3D Islands: %s" % stat_data["3D Islands"])

