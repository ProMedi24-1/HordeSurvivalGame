class_name GameManager
extends Node2D

var levels: Dictionary = {
    "TestLevel": "res://scenes/levels/test_level.tscn",
}

var level_ref: Node2D = null
var player_ref: Node2D = null

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    pass

func in_level() -> bool:
    return level_ref != null

func load_level(level_name: String) -> PackedScene:
    return load(levels[level_name])





