class_name CrystalMed extends PickupBase
## Medium crystal pickup.


func _ready() -> void:
	super()


## Pickup the crystal.
func on_pickup() -> void:
	GEntityAdmin.player.add_crystal(3)
	Sound.play_sfx(Sound.Fx.PICKUP_CRYSTAL, 1.5)
