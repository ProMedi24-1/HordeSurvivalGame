class_name CrystalSmall
extends PickupBase

func _ready() -> void:
    super()

func onPickup() -> void:
    GEntityAdmin.player.addCrystal(1)
