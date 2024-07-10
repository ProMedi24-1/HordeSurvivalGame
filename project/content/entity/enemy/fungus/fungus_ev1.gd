extends FungusEnemy
# Evolution 1.

var std_anim: Anim.SpriteAnim


# Constructor, configure the stats here!
func _init() -> void:
	health = 30
	mov_speed = 1200.0

	charge_distance = 100.0
	charge_speed = 5000.0
	charge_time = 1.0

	melee_damage = 8
	melee_cooldown = 0.8

	crystal_rating = 0.1
	ingredient = Ingredient.IngredientType.FUNGUS
	ingredient_chance = 0.3


func _ready() -> void:
	super()
	self.name = "FungusEnemy[Ev1]"

	std_anim = Anim.SpriteAnim.new(sprite, 4, 0.15)
	std_anim.looped = true
	std_anim.play()


# This is awful, because we are checking every frame
# if we are charging or not. But i dont care currently.
# TODO: Refactor this to use signals instead.
func _process(_delta) -> void:
	if is_charging:
		std_anim.set_speed(0.05)
	else:
		std_anim.set_speed(0.15)
