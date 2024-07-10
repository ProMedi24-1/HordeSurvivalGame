class_name CrystalSmall extends PickupBase
## Small crystal pickup.


func _ready() -> void:
	super()


## Pickup the crystal.
func on_pickup() -> void:
	GEntityAdmin.player.add_crystal(1)
	Sound.play_sfx(Sound.Fx.PICKUP_CRYSTAL, 1.5)
