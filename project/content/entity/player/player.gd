class_name Player extends Node2D
## Player entity with basic movement and stats.

enum HealthStatus {
	FULL,
	NORMAL,
	LOW,
	DEAD,
}

const LOW_HEALTH_THRESHOLD: float = 0.25  ## The threshold for low health.
const MAX_WEAPONS: int = 5  ## The maximum amount of weapons the player can have.
const STD_CAMERA_ZOOM: float = 2.5  ## The standard camera zoom.

## The normal sprite.
const NORMAL_SPRITE: Texture2D = preload("res://assets/entity/player/kitty.png")
## The right walk sprite.
const WALK_SPRITE: Texture2D = preload("res://assets/entity/player/kitty_right.png")
const NUM_WALK_FRAMES: int = 6  ## The number of walk frames.

# Nodes which must be linked.
@export var mov_body: CharacterBody2D
@export var sprite: Sprite2D
@export var hud_scene: PackedScene = preload("res://content/ui/hud/hud.tscn")
@export var camera: Camera2D

var max_health: int = 9  ## The maximum health of the player. Currently 9 hearts.
var health: int = max_health  ## The current health of the player.

var god_mode: bool = false  ## If the player is in god mode.
var health_status: HealthStatus = HealthStatus.FULL  ## The current health status of the player.

var mov_speed: float = 6000.0  ## The movement speed of the player.

var crystals: int = 0  ## The amount of crystals the player has.
var level: int = 0  ## The current level of the player.
var level_progress: int = 0  ## The progress towards the next level.
var first_level_req: int = 25  ## The first level requirement.
var level_required: int = first_level_req  ## The current level requirement.
var level_req_multiplier: float = 1.3  ## The multiplier for the next level requirement.


var weapon_inventory: Array[WeaponBase] = []  ## The weapons the player has.
var ingredient_inventory: Array[int] = []  ## The ingredients the player has.

## The (skill) rating of the player. Will determine the difficulty.
var player_rating: float = 10.0

var kills: int = 0  ## The amount of kills the player has.

# Factors to determine the player rating.
var damage_taken: int = 0 ## Amount of damage taken in a Wave.
var kills_in_wave: int = 0  ## Amount of kills in a Wave.




#var damage_taken: int = 0  ## The total amount of damage taken.
#var heal_taken: int = 0  ## The total amount of healing taken.



var camera_zoom_offset: float = 0.0  ## The offset for the camera zoom.

## The walk animation for our player.
## NOTE: This needs to be @onready because the sprite is not registered in the constructor.
@onready var walk_anim = Anim.SpriteAnim.new(sprite, NUM_WALK_FRAMES, 0.1)

func _ready() -> void:
	self.name = "Player"
	GEntityAdmin.register_entity(self)

	GPostProcessing.fade_from_black()

	ingredient_inventory.resize(Ingredient.IngredientType.keys().size())

	# Add Staff weapon
	var staff = preload("res://content/weapon/sword/sword.tscn").instantiate()
	add_child(staff)

	var staff2 = preload("res://content/weapon/staff/staff.tscn").instantiate()
	add_child(staff2)

	add_child(hud_scene.instantiate())
	set_camera_zoom()


func _physics_process(delta: float) -> void:
	if mov_body == null:
		return

	handle_player_movement(delta)
	mov_body.move_and_slide()


## Handle the player movement.
## [delta] The delta time.
func handle_player_movement(delta: float) -> void:
	var direction := Vector2.ZERO

	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")

	if direction.x != 0:
		sprite.texture = WALK_SPRITE
		sprite.hframes = NUM_WALK_FRAMES
		sprite.flip_h = direction.x < 0

		if not walk_anim.playing:
			walk_anim.looped = true
			walk_anim.play()

	else:
		sprite.texture = NORMAL_SPRITE
		sprite.hframes = 1
		sprite.frame = 0
		sprite.flip_h = false

		walk_anim.stop()

	mov_body.velocity = direction.normalized() * mov_speed * delta


## Set the health of the player.
## [value] The value to set the health to.
func set_health(value: int) -> void:
	self.health = value

	update_health_status()


## Set the maximum health of the player.
## [value] The value to set the maximum health to.
func set_max_health(value: int) -> void:
	self.max_health = value

	set_health(min(health, max_health))
	update_health_status()


## Damage the player by a certain amount. However the amount is currently
## irrelevant as the player only takes 1 heart of damage.
## [damage] The amount of damage to take.
func take_damage(_damage: int) -> void:
	if god_mode:
		return

	# new Health system just takes 1 heart of damage.
	#_damage = 1
	set_health(max(health - 1, 0))
	damage_taken += 1

	Sound.play_sfx(Sound.Fx.HIT_ENTITY)
	EntityEffects.play_hit_anim(sprite, Color.RED)

	if health <= 0:
		health_status = HealthStatus.DEAD
		die()


## Heal the player by a certain amount.
## [heal] The amount of healing to take.
#func take_heal(heal: int) -> void:
#	set_health(min(health + heal, max_health))
#	#heal_taken += heal
#	#playHealEffect()
#	update_health_status()


## Update the player rating. If adaptive is true, the player rating will be
## updated based on the performance in the current wave.
## [adaptive]: If the rating should be adaptive.
## [increase]: The increase in rating if not adaptive.
func update_player_rating(adaptive: bool, increase: float = 3.0) -> void:
	if adaptive:

		var rating = 10.0
		if damage_taken > 0:
			rating -= damage_taken / 10.0
		if kills_in_wave > 0:
			rating += kills_in_wave / 10.0

		player_rating = rating

	else:
		player_rating += increase



## Update the health status based on the current health.
func update_health_status() -> void:
	if health == max_health:
		health_status = HealthStatus.FULL
		return

	var health_percent = float(health) / max_health
	if health_percent <= LOW_HEALTH_THRESHOLD:
		health_status = HealthStatus.LOW
	else:
		health_status = HealthStatus.NORMAL


## Add crystals to the player.
## [amount] The amount of crystals to add.
func add_crystal(amount: int) -> void:
	crystals += amount
	GLogger.log("Player: Added %d crystals" % amount)

	level_progress += amount
	if level_progress >= level_required:
		level_up()


## Level up the player and update the requirement.
func level_up() -> void:
	level += 1
	level_progress = 0
	update_level_req()

	GLogger.log("Player: Level up to %d" % level)


## Update the level requirement.
func update_level_req() -> void:
	@warning_ignore("narrowing_conversion")
	level_required = int(first_level_req * pow(level_req_multiplier, level))


## Set the camera zoom.
func set_camera_zoom() -> void:
	camera.zoom = Vector2(
		STD_CAMERA_ZOOM + camera_zoom_offset, STD_CAMERA_ZOOM + camera_zoom_offset
	)


## Kill the player. This will show the game over menu.
func die() -> void:
	var death_menu = preload("res://content/ui/gameover_menu/gameover_menu.tscn").instantiate()
	GGameGlobals.instance.add_child(death_menu)

	GStateAdmin.pause_game(true)

	mov_body.visible = false
