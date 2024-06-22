class_name DebugProfilers
extends Object

# Frame Profiler
static var fpsCurrent: int
static var fpsAverage: int
static var fpsMax: int

static var frameTime: float
static var fpsBuffer := Utils.CircBuffer.new(50)

## Frame profiling window, showing FPS and Frametime.
static func showFrameWindow(p_open: Array) -> void:
	fpsCurrent = Engine.get_frames_per_second() as int
	fpsMax = Engine.max_fps

	frameTime = Performance.get_monitor(Performance.TIME_PROCESS)
	frameTime *= 1000
	const ftBudget := 8

	fpsBuffer.pushBack(fpsCurrent)

	fpsAverage = Utils.accumulate(fpsBuffer.buffer) / fpsBuffer.bufSize

	ImGui.SetNextWindowSize(Vector2(280, 130), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(850, 130), ImGui.Cond_Once)
	ImGui.Begin("Frame", p_open, ImGui.WindowFlags_NoSavedSettings)

	ImGui.Text("FPS: %d" % fpsCurrent)
	ImGui.SameLine()
	ImGui.Text("Avg: %d" % fpsAverage)
	ImGui.SameLine()
	ImGui.Text("Max %d" % fpsMax)

	if ImGui.BeginTable("ftTable", 2):
		ImGui.TableSetupColumnEx("", ImGui.TableColumnFlags_WidthFixed, 125)

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		ImGui.Text("FrameTime: %.2fms" % frameTime)

		ImGui.TableNextColumn()
		ImGui.ProgressBar(frameTime / ftBudget, Vector2( - 1, 15), "%d/%dms" % [frameTime, ftBudget])

		ImGui.EndTable()

	ImGui.Separator()
	ImGui.PlotLinesEx("##fpsPlot", fpsBuffer.buffer, fpsBuffer.bufSize, 0, "", 0, (fpsMax + 10), Vector2( - 1, 50))
	
	ImGui.End()

# Memory Profiler
static var showStatic := false
static var showRendering := false

## Memory profiling window.
static func showMemoryWindow(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(300, 170), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(830, 390), ImGui.Cond_Once)
	ImGui.Begin("Memory", p_open, ImGui.WindowFlags_NoSavedSettings)

	const memFlags := ImGui.TableFlags_Borders|ImGui.TableFlags_RowBg
	if ImGui.BeginTable("memTable", 2, memFlags):

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		showStatic = ImGui.CollapsingHeader("Static", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		const bToMB = 10e6
		if showStatic:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Static:")
			ImGui.TableNextColumn()
			ImGui.Text("%.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / bToMB))

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Static Max:")
			ImGui.TableNextColumn()
			ImGui.Text("%.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / bToMB))

		ImGui.TableNextRow()
		ImGui.TableNextColumn()
		showRendering = ImGui.CollapsingHeader("Rendering", ImGui.TreeNodeFlags_DefaultOpen)
		ImGui.TableNextColumn()
		ImGui.Text("")

		if showRendering:
			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Video:")
			ImGui.TableNextColumn()
			ImGui.Text("%.2f MB" % (Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / bToMB))

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Texture:")
			ImGui.TableNextColumn()
			ImGui.Text("%.2f MB" % (Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED) / bToMB))

			ImGui.TableNextRow()
			ImGui.TableNextColumn()
			ImGui.Text("Memory Buffer:")
			ImGui.TableNextColumn()
			ImGui.Text("%.2f MB" % (Performance.get_monitor(Performance.RENDER_BUFFER_MEM_USED) / bToMB))

		ImGui.EndTable()

	ImGui.End()

# Logger Window
static var scrollToBtm := [true]

# Log profiling window.
static func showLoggerWindow(p_open: Array) -> void:
	ImGui.SetNextWindowSize(Vector2(320, 250), ImGui.Cond_Once)
	ImGui.SetNextWindowPos(Vector2(430, 380), ImGui.Cond_Once)
	ImGui.Begin("Logger", p_open, ImGui.WindowFlags_NoSavedSettings)

	if ImGui.Button("Clear Log"):
		GLogger.clearLogBuffer()

	ImGui.SameLine()
	if ImGui.Button("Test Log"):
		GLogger.log("Test Log", Color.RED)
		GLogger.log("Test Log", Color.GREEN)
		GLogger.log("Test Log", Color.BLUE)

	ImGui.SameLine()
	ImGui.Checkbox("Scroll To Bottom", scrollToBtm)

	ImGui.Separator()

	if ImGui.BeginChild("ScrollingRegion", Vector2(0, 0), false):
		ImGui.PushTextWrapPos()

		for logMsg in GLogger.logBuffer:
			ImGui.TextColored(logMsg.getFirst(), logMsg.getSecond())

		ImGui.PopTextWrapPos()

		if scrollToBtm[0]:
			ImGui.SetScrollHereY(1.0)

		ImGui.EndChild()

	ImGui.End()
