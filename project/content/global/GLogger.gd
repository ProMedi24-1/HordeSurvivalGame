class_name GLogger
extends Object

const logBufSize := 200
static var logBuffer: Array = []

static func log(msg: String, color: Color=Color.GRAY) -> void:
	var now := Time.get_time_dict_from_system()
	var timeStr := "%02d:%02d:%02d" % [now.hour, now.minute, now.second]
	
	print_rich("[color=%s][%s][LOG][/color][color=%s] %s[/color]" % [Color.ORANGE.to_html(), timeStr, color.to_html(), msg])

	# Message formatted to be used in our ImGui-Logger.
	var bufMSG := "[%s][LOG] %s" % [timeStr, msg]
	var bufPair := Utils.Pair.new(color, bufMSG)
	logBuffer.append(bufPair)

	if logBuffer.size() > logBufSize:
		logBuffer.pop_front()

static func getLogBuffer() -> Array:
	return logBuffer

static func clearLogBuffer() -> void:
	logBuffer.clear()
