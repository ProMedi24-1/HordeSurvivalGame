class_name HoundEnemy extends EnemyBase
## Hound enemy, only has 1 evolution.

# Constructor, configure the stats here!
func _init() -> void:
	health = 70
	mov_speed = 2000.0
	melee_damage = 5
	melee_cooldown = 1

	crystal_rating = 1.0
	ingredient = Ingredient.IngredientType.NONE
	ingredient_chance = 0.7


func _ready() -> void:
	super()
	self.name = "HoundEnemy"

	movement_method = func(delta) -> void: EnemyUtils.move_to_player(mov_body, mov_speed, delta)
	var std_anim := Anim.SpriteAnim.new(sprite, 10, 0.15)
	std_anim.looped = true
	std_anim.play()


# Bad, because we are checking every frame.
# TODO: Refactor this to use signals instead.
func _process(_delta: float) -> void:
	# Flip sprite if moving left.
	EnemyUtils.flip_sprite(sprite, mov_body)
