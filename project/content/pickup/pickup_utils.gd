class_name PickupUtils
## Utility functions for pickups such as spawning crystals, ingredients, etc.

## The type of crystal.
enum CrystalType {
	SMALL,
	MED,
	LARGE,
}


## Spawn a crystal at a position.
## [pos]: The position to spawn at.
## [type]: The type of crystal to spawn.
static func spawn_crystal(pos: Vector2, type: CrystalType) -> void:
	const CRYSTAL_SCENES = {
		CrystalType.SMALL: preload("res://content/pickup/crystal/crystal_small.tscn"),
		CrystalType.MED: preload("res://content/pickup/crystal/crystal_med.tscn"),
		CrystalType.LARGE: preload("res://content/pickup/crystal/crystal_large.tscn"),
	}

	var crystal_inst = CRYSTAL_SCENES[type].instantiate()
	crystal_inst.global_position = pos
	GSceneAdmin.scene_root.add_child.call_deferred(crystal_inst)


## Spawn a ingredient at a position.
## [pos]: The position to spawn at.
## [type]: The type of ingredient to spawn.
static func spawn_ingredient(
	pos: Vector2,
	type: Ingredient.IngredientType,
) -> void:
	var ingredient_inst = Ingredient.ingredient_types[type].scene.instantiate()
	ingredient_inst.global_position = pos
	GSceneAdmin.scene_root.add_child.call_deferred(ingredient_inst)


static func add_ingredient_to_player(type: Ingredient.IngredientType, amount: int = 1) -> void:
	var player := GEntityAdmin.player

	if player == null:
		return

	player.ingredient_inventory[type] += amount
	GLogger.log("Player: Added %s" % Ingredient.ingredient_types[type].name)
