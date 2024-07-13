class_name LevelBase extends Node

signal ambience_changed(ambience: LevelAmbience)
signal time_changed()

enum LevelAmbience {
	NON_SPOOKY,
	HALF_SPOOKY,
	SPOOKY,
}

@export var level_modulate: CanvasModulate

var ambience_state: LevelAmbience = LevelAmbience.NON_SPOOKY
var time_elapsed: int = 0
static var time_elapsed_wave: int = 0
var hold_time: bool = false

static var ambience_map: Dictionary = {
	LevelAmbience.NON_SPOOKY: Color.from_string("#e8d4d4", Color.GRAY),
	LevelAmbience.HALF_SPOOKY: Color.from_string("#9a6e6e", Color.GRAY),
	LevelAmbience.SPOOKY: Color.from_string("#3f2929", Color.GRAY),
}

func _ready() -> void:
	var level_timer := Timer.new()

	level_timer.wait_time = 1
	level_timer.one_shot = false;
	level_timer.connect("timeout", update_time)
	add_child(level_timer)
	level_timer.start()

## Update the time elapsed.
func update_time() -> void:
	if hold_time:
		return

	time_elapsed += 1
	time_elapsed_wave += 1
	time_changed.emit()


## Returns the elapsed time as a string.
func get_time_string() -> String:
	@warning_ignore("integer_division")
	return "%02d:%02d" % [time_elapsed / 60, time_elapsed % 60]


func change_ambience(ambience: LevelAmbience) -> void:
	#GPostProcessing.fade_to_black()

	var ambience_change = func() -> void:
		ambience_state = ambience
		level_modulate.color = ambience_map[ambience]


	GPostProcessing.fade_transition(ambience_change)

	ambience_changed.emit(ambience)

	#GPostProcessing.fade_from_black()

