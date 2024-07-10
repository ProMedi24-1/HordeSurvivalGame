extends FungusEnemy
# Evolution 3.

var std_anim: Anim.SpriteAnim


# Constructor, configure the stats here!
func _init() -> void:
	health = 100
	mov_speed = 1400.0

	charge_distance = 2500.0
	charge_speed = 6000.0
	charge_time = 1.5

	melee_damage = 8
	melee_cooldown = 0.8

	crystal_rating = 0.8
	ingredient = Ingredient.IngredientType.FUNGUS
	ingredient_chance = 1.0


func _ready() -> void:
	super()
	self.name = "FungusEnemy[Ev3]"

	std_anim = Anim.SpriteAnim.new(sprite, 16, 0.06)
	std_anim.looped = true
	std_anim.play()


# This is awful, because we are checking every frame
# if we are charging or not. But i dont care currently.
# TODO: Refactor this to use signals instead.
func _process(_delta) -> void:
	if is_charging:
		std_anim.set_speed(0.02)
	else:
		std_anim.set_speed(0.06)
