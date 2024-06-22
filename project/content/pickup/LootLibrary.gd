class_name LootLibrary
extends Object

enum LootTier {
    COMMON = 0,
    RARE = 1,
    EPIC = 2,
    LEGENDARY = 3
}

static var lootDict := {

}

static func spawnCrystal(pos: Vector2) -> void:
    var crystal = preload ("res://content/pickup/crystal/crystal_small.tscn").instantiate()
    GSceneAdmin.levelBase.add_child(crystal)
    crystal.global_position = pos
    