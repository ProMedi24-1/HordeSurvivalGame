class_name BatWing extends PickupBase
## Batwing pickup.


func _ready() -> void:
	super()


## Pickup the batwing.
func on_pickup() -> void:
	PickupUtils.add_ingredient_to_player(Ingredient.IngredientType.BATWING)
	Sound.play_sfx(Sound.Fx.PICKUP_CRYSTAL, 1.5)
