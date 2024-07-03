class_name CrystalSmall
extends PickupBase

func _ready() -> void:
	super()

func onPickup() -> void:
	GEntityAdmin.player.addCrystal(1)

	Effects.Sound.play(SoundBundles.pickupCrystal, 1.5)

# static func spawn(pos: Vector2) -> void:
# 	var crystalInstance = preload ("res://content/pickup/crystal/crystal_small.tscn").instantiate()
# 	crystalInstance.global_position = pos
# 	GSceneAdmin.levelBase.add_child(crystalInstance)
	
