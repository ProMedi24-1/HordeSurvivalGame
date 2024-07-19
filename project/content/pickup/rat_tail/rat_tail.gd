class_name RatTail extends PickupBase
## RatTail pickup.


func _ready() -> void:
	super()


## Pickup the fungus.
func on_pickup() -> void:
	PickupUtils.add_ingredient_to_player(Ingredient.IngredientType.RATTAIL)
	Sound.play_sfx(Sound.Fx.PICKUP_CRYSTAL, 1.5)