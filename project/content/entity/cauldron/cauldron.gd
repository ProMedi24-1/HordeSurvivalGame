extends Node2D

@onready var fire_animation = $Effects/FireAnimation
@onready var liquid_animation = $Effects/LiquidAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    fire_animation.play("Idle")
    liquid_animation.play("Idle")

