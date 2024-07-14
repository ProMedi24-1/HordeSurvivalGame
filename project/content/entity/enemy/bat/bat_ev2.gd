extends BatEnemy
# Evolution 2.

# Constructor, configure the stats here!
func _init() -> void:
	health      = 15
	mov_speed    = 1200.0

	melee_damage = 5
	melee_cooldown = 1

	crystal_rating = 0.4
	ingredient = Ingredient.IngredientType.BATWING
	ingredient_chance = 0.7

func _ready() -> void:
	super()
	self.name = "BatEnemy[Ev2]"

	var std_anim := Anim.SpriteAnim.new(sprite, 5, 0.15)
	std_anim.looped = true
	std_anim.play()
