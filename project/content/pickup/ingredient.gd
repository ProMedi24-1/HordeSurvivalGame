class_name Ingredient
## Class for handling ingredients.


## The base class for an ingredient.
class IngredientBase:
	var name: String  ## The name of the ingredient.
	var icon_texture: Texture2D  ## The icon texture of the ingredient.
	var scene: PackedScene  ## The scene of the pickup.

	func _init(_name: String, _icon_texture: Texture2D, _scene: PackedScene) -> void:
		self.name = _name
		self.icon_texture = _icon_texture
		self.scene = _scene


## The type of ingredient.
enum IngredientType {
	NONE,
	BATWING,
	FUNGUS,
	RATTAIL,
}

## Static map of ingredient types which loads the neccecary data.
static var ingredient_types = {
	IngredientType.BATWING:
	IngredientBase.new(
		"Batwing",
		preload("res://assets/pickup/ingredient/bat_wing.png"),
		load("res://content/pickup/bat_wing/bat_wing.tscn"),
	),
	IngredientType.FUNGUS:
	IngredientBase.new(
		"Fungus",
		preload("res://assets/pickup/ingredient/fungus.png"),
		load("res://content/pickup/fungus/fungus.tscn"),
	),
	IngredientType.RATTAIL:
	IngredientBase.new(
		"Rattail",
		preload("res://assets/pickup/ingredient/rat_tail.png"),
		load("res://content/pickup/rat_tail/rat_tail.tscn"),
	),
}
