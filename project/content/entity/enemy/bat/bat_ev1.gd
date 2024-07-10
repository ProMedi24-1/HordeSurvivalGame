extends BatEnemy
# Evolution 1.

# Constructor, configure the stats here!
func _init() -> void:
	health      = 10
	mov_speed    = 1000.0

	melee_damage = 5
	melee_cooldown = 1

	crystal_rating = 0.1
	ingredient = Ingredient.IngredientType.BATWING
	ingredient_chance = 0.3

func _ready() -> void:
	super()
	self.name = "BatEnemy[Ev1]"

	var std_anim := Anim.SpriteAnim.new(sprite, 5, 0.15)
	std_anim.looped = true
	std_anim.play()
