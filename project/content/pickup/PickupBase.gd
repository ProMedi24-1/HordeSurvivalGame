class_name PickupBase
extends Node2D

@export var hitbox: Area2D
@export var pickupSound: AudioStream

func _ready() -> void:
    if hitbox == null:
        return
    
    hitbox.connect("body_entered", pickup)

func pickup(_Node) -> void:
    onPickup() # Custom pickup function for chilren.

    Effects.playSound(pickupSound)
    hitbox.queue_free()
    playPickupAnim()

# Override
func onPickup() -> void:
    pass

func playPickupAnim() -> void:
    var tween = self.create_tween()
    tween.tween_property(self, "scale", Vector2(), 0.1)
    tween.tween_callback(self.queue_free)
