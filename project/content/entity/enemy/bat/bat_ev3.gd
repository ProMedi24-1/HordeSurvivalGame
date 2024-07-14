extends BatEnemy
# Evolution 3.

# Constructor, configure the stats here!
func _init() -> void:
	health      = 30
	mov_speed    = 1400.0

	melee_damage = 5
	melee_cooldown = 1

	crystal_rating = 0.7
	ingredient = Ingredient.IngredientType.BATWING
	ingredient_chance = 1.0

func _ready() -> void:
	super()
	self.name = "BatEnemy[Ev3]"

	var std_anim := Anim.SpriteAnim.new(sprite, 5, 0.15)
	std_anim.looped = true
	std_anim.play()
