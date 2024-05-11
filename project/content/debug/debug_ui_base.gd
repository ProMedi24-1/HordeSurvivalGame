class_name DebugUiBase
extends Node

var ui_name: String
var show := [true]

func _init(_ui_name: String, _show: bool = true) -> void:
    self.ui_name = _ui_name
    self.show[0] = _show

func _ready() -> void:
    GameGlobals.logger.log(str(ui_name + " ready"), Color.SKY_BLUE)

func _process(_delta: float) -> void:
    if show[0]:
        draw_contents(show)

# OVERRIDE
func draw_contents(_p_show: Array = [true]) -> void:
    pass