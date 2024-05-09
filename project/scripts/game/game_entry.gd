extends Node2D
## Game entry point.

# This node deletes itself since we are using the GameRoot which is autoloaded as the base.
# However we still need a main_scene configured, so we use this.
func _ready() -> void:
    print_rich("[color=BLUE]Entering Game[/color]")
    self.queue_free()

