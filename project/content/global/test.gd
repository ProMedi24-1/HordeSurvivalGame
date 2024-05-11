extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    GameGlobals.logger.connect("logged", _on_logged)

    GameGlobals.logger.log("Scene ready", Color.GREEN_YELLOW)
    GameGlobals.logger.log("wtf")
    GameGlobals.logger.log("wtf")
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _on_logged(message: String, color: Color) -> void:
    print("logged a message")
