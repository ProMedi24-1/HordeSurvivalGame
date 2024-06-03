class_name LevelBaseComponent    
extends Node2D

## Editor-Tool for adjusting Level Settings.
#@export var level_settings: LevelSettings
@export var level_timer: Timer
## What is the time step in seconds. DO NOT CHANGE!
const time_step: float = 1.0

## The difficulty of the level as a float 0(easy)-100(hard).
## Normally this would increase linear over time.
## Will be important for the adaptive difficulty.
const max_difficulty: float = 100
var difficulty: float = 0
var is_adaptive: bool = false
var decouple_time: bool = false
var difficulty_static: bool = false

## The time elapsed in seconds.
var max_time: float  = 600
var time_elapsed: float = 0
var hold: bool = false

@export_category("Ambience")
@export var world_modulate: CanvasModulate
@export var world_environment: WorldEnvironment

var kills

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    level_timer.wait_time = time_step
    level_timer.one_shot = false;
    level_timer.connect("timeout", _on_level_timer_timeout)
    level_timer.start()



    GameGlobals.logger.log("LevelBaseComponent ready", Color.PURPLE)

## Called every second.
func _on_level_timer_timeout() -> void:
    if hold:
        return

    if time_elapsed >= max_time:
        GameGlobals.logger.log("Max Time reached")
    else:
        time_elapsed += 1
        update_difficulty()

## Updates the Difficulty every second.
func update_difficulty() -> void:
    if difficulty_static:
        return

    if is_adaptive:
        #TODO
        update_adaptive()
    else:
        update_linear()
        

func update_linear() -> void:
    if difficulty >= max_difficulty:
        return

    if decouple_time:
        difficulty += (100 / max_time)
        difficulty = min(difficulty, max_difficulty)
        
    else:
        difficulty = ((time_elapsed / max_time) * 100)
        difficulty = min(difficulty, max_difficulty)

# TODO: update the difficulty adaptively via a bumer of factors.
func update_adaptive() -> void:
    pass    

## Get a formatted string of time in seconds.
func get_time_string(time: float) -> String:
    #return "%.2f:%.2f" % [time_elapsed / 3600, time_elapsed / 60]
    @warning_ignore("integer_division")
    var minutes = int(time) / 60
    var seconds = int(time) % 60
    return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
