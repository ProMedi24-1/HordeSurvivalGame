extends FungusEnemy
# Evolution 2.

var std_anim: Anim.SpriteAnim


# Constructor, configure the stats here!
func _init() -> void:
	health = 50
	mov_speed = 1300.0

	charge_distance = 200.0
	charge_speed = 5500.0
	charge_time = 2.0

	melee_damage = 8
	melee_cooldown = 0.8

	crystal_rating = 0.3
	ingredient = Ingredient.IngredientType.FUNGUS
	ingredient_chance = 0.5


func _ready() -> void:
	super()
	self.name = "FungusEnemy[Ev2]"

	std_anim = Anim.SpriteAnim.new(sprite, 8, 0.13)
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
