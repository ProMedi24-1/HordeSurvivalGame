class_name EnemyBase extends Node2D
## Base Class for all enemies.

# Nodes which must be linked.
@export var mov_body: CharacterBody2D
@export var sprite: Sprite2D
@export var hit_box: Area2D

var health: int = 100  ## The health of the enemy.
var mov_speed: float = 2000.0  ## The movement speed of the enemy.

var melee_damage: int = 5  ## The damage the enemy does in melee.
var melee_cooldown: float = 0.3  ## The cooldown between melee attacks.
var cooldown: Tween
var player_touching: bool = false  ## If the player is touching the enemy.

## The rating for the crystal spawn. High rating means better chance
## for a larger crystal type.
var crystal_rating: float = 0.2
## The ingredient type to spawn.
var ingredient: Ingredient.IngredientType = Ingredient.IngredientType.NONE
var ingredient_chance: float = 0.5  ## The chance to spawn an ingredient.

var movement_method: Callable  ## The function to move the enemy.


func _ready() -> void:
	self.name = "Enemy"

	GEntityAdmin.register_entity(self)

	hit_box.connect("body_entered", on_player_enter)
	hit_box.connect("body_exited", on_player_exit)


func _exit_tree() -> void:
	GEntityAdmin.unregister_entity(self)


func _physics_process(delta: float) -> void:
	movement_method.call(delta)
	mov_body.move_and_slide()


## Damage the enemy by a certain amount.
## [damage] The amount of damage to take.
func take_damage(damage: int) -> void:
	health -= damage

	Sound.play_sfx(Sound.Fx.HIT_ENTITY)
	EntityEffects.add_damage_numbers(self, damage, false)
	EntityEffects.play_hit_anim(sprite, Color.RED)
	CameraEffects.play_camera_shake()

	if health <= 0:
		die()


## Kill the enemy and spawn loot.
func die() -> void:
	EnemyUtils.spawn_loot(self.global_position, crystal_rating, ingredient, ingredient_chance)

	if GEntityAdmin.player:
		GEntityAdmin.player.kills += 1
		GEntityAdmin.player.kills_in_wave += 1

	# TODO: Play death animation.
	self.get_parent().queue_free()


## Called when the player touches the enemy hitbox.
func on_player_enter(body: Node2D) -> void:
	if body != GEntityAdmin.player:
		return

	player_touching = true

	var do_damage := func() -> void: GEntityAdmin.player.take_damage(melee_damage)
	do_damage.call()
	cooldown = create_tween()
	cooldown.set_loops()
	cooldown.tween_callback(do_damage).set_delay(melee_cooldown)


## Called when the player exits the enemy hitbox.
func on_player_exit(body: Node2D) -> void:
	if body != GEntityAdmin.player:
		return

	player_touching = false
	cooldown.kill()
