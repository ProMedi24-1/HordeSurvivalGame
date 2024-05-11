class_name Logger
extends Node

signal logged(msg: String, color: Color)

const META_COLOR: Color = Color.ORANGE
const DEFAULT_COLOR: Color = Color.GRAY

func log(msg: String, color: Color = DEFAULT_COLOR) -> void:
    var time = Time.get_time_dict_from_system()
    var time_str = "%02d:%02d:%02d" % [time.hour, time.minute, time.second]

    
    print_rich("[color=%s][%s][LOG][/color][color=%s] %s[/color]" % [META_COLOR.to_html(), time_str, color.to_html(), msg])

    var output = "[%s][LOG] %s" % [time_str, msg]
    logged.emit(output, color)

func _ready() -> void:
    self.log("Logger ready", Color.GREEN_YELLOW)
