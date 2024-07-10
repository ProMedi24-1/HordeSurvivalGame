class_name EnemyUtils
## Utility functions for enemies such as movement, spawning loot, etc.


## Move the enemy towards the player. This sets the velocity towards the player.
## [mov_body] The body to move.
## [mov_speed] The speed to move at.
## [delta] The delta time.
static func move_to_player(mov_body: CharacterBody2D, mov_speed: float, delta: float) -> void:
	var player := GEntityAdmin.player
	if player == null or mov_body == null:
		return

	var direction := Vector2.ZERO

	direction = mov_body.global_position.direction_to(player.mov_body.global_position)

	mov_body.velocity = direction.normalized() * mov_speed * delta


## Move the enemy towards a direction. This sets the velocity towards the direction.
## [mov_body] The body to move.
## [direction] The direction to move towards.
## [mov_speed] The speed to move at.
## [delta] The delta time.
static func move_to_direction(
	mov_body: CharacterBody2D, direction: Vector2, mov_speed: float, delta: float
) -> void:
	mov_body.velocity = direction.normalized() * mov_speed * delta


## Spawn loot at a position. This spawns crystals and ingredients.
## [pos] The position to spawn at.
## [crystal_rating] The chance to spawn a crystal.
## [ingredient] The ingredient to spawn.
## [ingredient_chance] The chance to spawn an ingredient.
static func spawn_loot(
	pos: Vector2,
	crystal_rating: float,
	ingredient: Ingredient.IngredientType,
	ingredient_chance: float = 0.5
) -> void:
	var crystal_spawned = false

	var rand_large = randf_range(0.0, 1.0)
	if rand_large <= crystal_rating * 0.5:
		PickupUtils.spawn_crystal(pos, PickupUtils.CrystalType.LARGE)
		crystal_spawned = true

	var rand_med = randf_range(0.0, 1.0)
	if not crystal_spawned and rand_med <= crystal_rating * 0.8:
		PickupUtils.spawn_crystal(pos, PickupUtils.CrystalType.MED)
		crystal_spawned = true

	if not crystal_spawned:
		PickupUtils.spawn_crystal(pos, PickupUtils.CrystalType.SMALL)

	if ingredient == Ingredient.IngredientType.NONE:
		return

	var rand = randf_range(0.0, 1.0)
	if rand <= ingredient_chance:
		PickupUtils.spawn_ingredient(pos, ingredient)

## Flips the sprite based on the velocity of the body.
## [sprite] The sprite to flip.
## [mov_body] The body to check the velocity of.
static func flip_sprite(sprite: Sprite2D, mov_body: CharacterBody2D) -> void:
	if mov_body.velocity.x < 0:
		sprite.flip_h = true
	elif mov_body.velocity.x > 0:
		sprite.flip_h = false
