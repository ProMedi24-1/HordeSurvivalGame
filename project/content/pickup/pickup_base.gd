class_name PickupBase extends Node2D
## Base class for all pickups.

@export var hitbox: Area2D  ## The hitbox for the pickup.


func _ready() -> void:
	self.name = "PickupBase"

	if hitbox == null:
		return

	hitbox.connect("body_entered", pickup)


## Pickup the pickup.
## [_Node]: The node that entered the hitbox, not used.
func pickup(_node) -> void:
	on_pickup()  # Custom pickup function for chilren.

	hitbox.queue_free()
	play_pickup_anim()


## Override in children.
func on_pickup() -> void:
	pass


## Play the pickup animation.
func play_pickup_anim() -> void:
	var tween = self.create_tween()
	tween.tween_property(self, "scale", Vector2(), 0.1)
	tween.tween_callback(self.queue_free)
