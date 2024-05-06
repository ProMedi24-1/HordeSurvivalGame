extends CharacterBody2D
class_name PlayerCharacter

# Player stats
var max_speed: float = 300.0
var current_speed: float = max_speed

var max_health: int = 100
var current_health: int = max_health


func _physics_process(_delta: float) -> void:
    handle_movement()
    move_and_slide()

func handle_movement() -> void:
    var direction := Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = direction * current_speed
    else:
        velocity.x = move_toward(velocity.x, 0, current_speed)
