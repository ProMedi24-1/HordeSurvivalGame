class_name EntityAdmin
extends Node

static var entities: Array = [] 
static var player: Player


func _ready() -> void:
    GameGlobals.logger.log("EntityAdmin ready", Color.GREEN_YELLOW)

    
