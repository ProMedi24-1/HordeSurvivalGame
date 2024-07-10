class_name GLogger
## Custom Global Logger for managing and displaying logs with rich text formatting.

const LOG_BUF_SIZE := 200  ## The maximum size of the log buffer.
static var log_buffer: Array = []  ## Static array to hold log messages and their associated colors.


## Logs a message with optional color formatting.
## [msg]: The message to log.
## [color]: The color to use for the message text (defaults to gray).
static func log(msg: String, color: Color = Color.GRAY) -> void:
	var now := Time.get_time_dict_from_system()
	var time_str := "%02d:%02d:%02d" % [now.hour, now.minute, now.second]

	print_rich(
		(
			"[color=%s][%s][LOG][/color][color=%s] %s[/color]"
			% [Color.ORANGE.to_html(), time_str, color.to_html(), msg]
		)
	)

	# Message formatted to be used in our ImGui-Logger.
	var buf_msg := "[%s][LOG] %s" % [time_str, msg]
	var buf_pair := Pair.new(color, buf_msg)
	log_buffer.append(buf_pair)

	if log_buffer.size() > LOG_BUF_SIZE:
		log_buffer.pop_front()


## Clears all messages from the log buffer.
static func clear_log_buffer() -> void:
	log_buffer.clear()
