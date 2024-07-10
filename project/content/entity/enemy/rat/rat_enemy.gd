class_name RatEnemy extends EnemyBase
## Rat enemy with basic movement and attack, only has one evolution.


# Constructor, configure the stats here!
func _init() -> void:
	health = 10
	mov_speed = 2000.0
	melee_damage = 5
	melee_cooldown = 1

	crystal_rating = 0.2
	ingredient = Ingredient.IngredientType.NONE
	ingredient_chance = 0.7


func _ready() -> void:
	super()
	self.name = "RatEnemy"

	# Set movement to basic move to player.
	movement_method = func(delta) -> void:
		EnemyUtils.move_to_player(mov_body, mov_speed, delta)

	var std_anim := Anim.SpriteAnim.new(sprite, 5, 0.15)
	std_anim.looped = true
	std_anim.play()


# Bad, because we are checking every frame.
# TODO: Refactor this to use signals instead.
func _process(_delta: float) -> void:
	# Flip sprite if moving left.
	EnemyUtils.flip_sprite(sprite, mov_body)
