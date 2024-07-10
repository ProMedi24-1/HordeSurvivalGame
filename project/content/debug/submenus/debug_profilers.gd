class_name DebugProfilers
## ImGui Profiler menus for tracking performance, memory and logs.

static var fps_current: int
static var fps_average: int
static var fps_max: int
static var frame_time: float
static var fps_buffer := CircBuffer.new(50)

static var show_static := false
static var show_rendering := false

static var scroll_to_btm := [true]


static func show_frame_window(p_open: Array) -> void:
	fps_current = Engine.get_frames_per_second() as int
	fps_max = Engine.max_fps

	frame_time = Performance.get_monitor(Performance.TIME_PROCESS)
	frame_time *= 1000
	const FT_BUDGET := 8

	fps_buffer.push_back(fps_current)

	fps_average = Math.accumulate(fps_buffer.buffer) / fps_buffer.buf_size

	ImGui.SetNextWindowSize(Vector2(280, 130), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(850, 130), ImGui.Cond_Once)
	ImGui.Begin("Frame", p_open, ImGui.WindowFlags_NoSavedSettings)

	ImGui.Text("FPS: %d" % fps_current)
	ImGui.SameLine()
	ImGui.Text("Avg: %d" % fps_average)
	ImGui.SameLine()
	ImGui.Text("Max %d" % fps_max)

	if ImGui.BeginTable("ftTable", 2):
		ImGui.TableSetupColumnEx("", ImGui.TableColumnFlags_WidthFixed, 125)

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("FrameTime: %.2fms" % frame_time)

		ImGui.TableNextColumn()
		ImGui.ProgressBar(
			frame_time / FT_BUDGET, Vector2(-1, 15), "%d/%dms" % [frame_time, FT_BUDGET]
		)

		ImGui.EndTable()

	ImGui.Separator()
	ImGui.PlotLinesEx(
		"##fpsPlot", fps_buffer.buffer, fps_buffer.buf_size, 0, "", 0, fps_max + 10, Vector2(-1, 50)
	)

	ImGui.End()


static func show_memory_window(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(300, 170), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(830, 390), ImGui.Cond_Once)
	ImGui.Begin("Memory", p_open, ImGui.WindowFlags_NoSavedSettings)

	const MEM_FLAGS := ImGui.TableFlags_Borders | ImGui.TableFlags_RowBg
	if ImGui.BeginTable("memTable", 2, MEM_FLAGS):
		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		show_static = ImGui.CollapsingHeader("Static", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		const B_TO_MB := 10e6
		if show_static:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Static:")
			ImGui.TableNextColumn()
			ImGui.Text("%.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / B_TO_MB))

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Static Max:")
			ImGui.TableNextColumn()
			ImGui.Text(
				"%.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / B_TO_MB)
			)

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		show_rendering = ImGui.CollapsingHeader("Rendering", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		if show_rendering:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Video:")
			ImGui.TableNextColumn()
			ImGui.Text(
				"%.2f MB" % (Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / B_TO_MB)
			)

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Texture:")
			ImGui.TableNextColumn()
			ImGui.Text(
				"%.2f MB" % (Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED) / B_TO_MB)
			)

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Buffer:")
			ImGui.TableNextColumn()
			ImGui.Text(
				"%.2f MB" % (Performance.get_monitor(Performance.RENDER_BUFFER_MEM_USED) / B_TO_MB)
			)

		ImGui.EndTable()

	ImGui.End()


static func show_logger_window(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(320, 250), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(430, 380), ImGui.Cond_Once)
	ImGui.Begin("Logger", p_open, ImGui.WindowFlags_NoSavedSettings)

	if ImGui.Button("Clear Log"):
		GLogger.clear_log_buffer()

	ImGui.SameLine()
	if ImGui.Button("Test Log"):
		GLogger.log("Test Log", Color.RED)
		GLogger.log("Test Log", Color.GREEN)
		GLogger.log("Test Log", Color.BLUE)

	ImGui.SameLine()
	ImGui.Checkbox("Scroll To Bottom", scroll_to_btm)

	ImGui.Separator()

	if ImGui.BeginChild("ScrollingRegion", Vector2(0, 0), false):
		ImGui.PushTextWrapPos()

		for log_msg in GLogger.log_buffer:
			ImGui.TextColored(log_msg.first, log_msg.second)

		ImGui.PopTextWrapPos()

		if scroll_to_btm[0]:
			ImGui.SetScrollHereY(1.0)

		ImGui.EndChild()

	ImGui.End()
