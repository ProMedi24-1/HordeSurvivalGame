class_name LevelBase
extends Node

#signal timeChanged()

const maxDifficulty = 100
var difficulty: int = 0
var isAdaptive: bool = false
var isDecoupled: bool = false
var isStatic: bool = false

var maxTime = 600
var timeElapsed: int = 0
var holdTime: bool = false

var wave: int = 0

func _ready() -> void:
	var levelTimer := Timer.new()
	
	levelTimer.wait_time = 1
	levelTimer.one_shot = false;
	levelTimer.connect("timeout", updateTime)
	add_child(levelTimer)
	levelTimer.start()

	GLogger.log("LevelBase: Ready", Color.GREEN_YELLOW)

func updateTime() -> void:
	if holdTime:
		return

	if timeElapsed >= maxTime:
		GLogger.log("Max Time reached")
		updateDifficulty()
	else:
		timeElapsed += 1
		updateDifficulty()

	#timeChanged.emit()

func updateDifficulty() -> void:
	if isStatic:
		return

	if isAdaptive:
		updateAdaptive()
	else:
		updateLinear()

func updateLinear() -> void:
	if isDecoupled:
		@warning_ignore("integer_division")
		difficulty += (100 / maxTime)
		difficulty = min(difficulty, maxDifficulty)
		
	else:
		@warning_ignore("integer_division")
		difficulty = ((timeElapsed / maxTime) * 100)
		difficulty = min(difficulty, maxDifficulty)

func updateAdaptive() -> void:
	# TODO: Implement.
	pass

func getTimeString() -> String:
	@warning_ignore("integer_division")
	return "%02d:%02d" % [timeElapsed / 60, timeElapsed % 60]
