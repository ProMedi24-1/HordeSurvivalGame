class_name CrystalLarge extends PickupBase
## Large crystal pickup.


func _ready() -> void:
	super()


## Pickup the crystal.
func on_pickup() -> void:
	GEntityAdmin.player.add_crystal(5)
	Sound.play_sfx(Sound.Fx.PICKUP_CRYSTAL, 1.5)
