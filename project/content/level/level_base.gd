class_name LevelBase
extends Node

#signal timeChanged()

const max_difficulty = 100
var difficulty: int = 0
var is_adaptive: bool = false
var is_decoupled: bool = false
var is_static: bool = false

var max_time = 600
var time_elapsed: int = 0
var hold_time: bool = false


func _ready() -> void:
	var level_timer := Timer.new()

	level_timer.wait_time = 1
	level_timer.one_shot = false;
	level_timer.connect("timeout", update_time)
	add_child(level_timer)
	level_timer.start()

	#GLogger.log("LevelBase: Ready", Color.GREEN_YELLOW)

func update_time() -> void:
	if hold_time:
		return

	if time_elapsed >= max_time:
		GLogger.log("Max Time reached")
		#update_difficulty()
	else:
		time_elapsed += 1
		#update_difficulty()

	#time_changed.emit()
	#print(difficulty)

# func update_difficulty() -> void:
# 	if is_static:
# 		return

# 	if is_adaptive:
# 		update_adaptive()
# 	else:
# 		update_linear()

# func updateLinear() -> void:
# 	if isDecoupled:
# 		@warning_ignore("integer_division")
# 		difficulty += (100 / maxTime)
# 		difficulty = min(difficulty, maxDifficulty)

# 	else:
# 		@warning_ignore("integer_division")
# 		difficulty = ((timeElapsed / maxTime) * 100)
# 		difficulty = min(difficulty, maxDifficulty)

# func updateAdaptive() -> void:
# 	# TODO: Implement.
# 	pass

func get_time_string() -> String:
	@warning_ignore("integer_division")
	return "%02d:%02d" % [time_elapsed / 60, time_elapsed % 60]
