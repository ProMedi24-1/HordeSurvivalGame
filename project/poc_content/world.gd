extends Node2D

@export var adaptive = true
var difficulty_level = 50

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func change_difficulty_level(diff):
    if adaptive:
        difficulty_level += diff
        difficulty_level = min(difficulty_level, 0)
        difficulty_level = min(difficulty_level, 100)
    else:
        pass # don't change difficulty level for fixed mode
