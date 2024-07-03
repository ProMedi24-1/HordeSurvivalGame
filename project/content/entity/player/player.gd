class_name Player extends Node2D
# Player class.


# Member Variables
enum HealthStatus {
	FULL,
	NORMAL,
	LOW,
	DEAD,
}

var maxHealth: int              = 9
var health: int                 = maxHealth

var godMode: bool               = false
var healthStatus: HealthStatus  = HealthStatus.FULL
const lowHealthThreshold: float = 0.25

var movSpeed: float = 5000.0

var crystals: int             = 0
var level: int                = 0
var levelProgress: int        = 0
var firstLevelReq: int        = 25
var levelRequired: int        = firstLevelReq
var levelReqMultiplier: float = 1.3

var weaponInventory: Array[WeaponBase] = []
var ingredientInventory: Array[int] = []

var kills: int       = 0
var damageTaken: int = 0
var healTaken: int   = 0

const defCamZoom: float = 2.5
var cameraZoomOffset: float = 0.0


# Linkable Nodes
@export var movBody: CharacterBody2D
@export var playerSprite: Sprite2D
@export var hudRes: PackedScene = preload ("res://content/ui/hud/hud.tscn")
@export var camera: Camera2D


# Godot virtual functions
func _ready() -> void:
	GEntityAdmin.registerEntity(self)

	ingredientInventory.resize(Ingredient.IngredientType.keys().size())

	# Add Staff weapon
	var staff = preload("res://content/weapon/staff/staff.tscn").instantiate()
	add_child(staff)


	add_child(hudRes.instantiate())
	setCameraZoom()

func _physics_process(delta: float) -> void:
	if movBody == null:
		return
	
	handlePlayerMovement(delta)
	movBody.move_and_slide()


# Custom functions
func handlePlayerMovement(delta: float) -> void:
	var direction := Vector2.ZERO

	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	movBody.velocity = direction.normalized() * movSpeed * delta


func setHealth(value: int) -> void:
	self.health = value

	updateHealthStatus()


func setMaxHealth(value: int) -> void:
	self.maxHealth = value

	setHealth(min(health, maxHealth))
	updateHealthStatus()


func takeDamage(damage: int) -> void:
	if godMode:
		return

	setHealth(max(health - damage, 0))
	damageTaken += damage

	Effects.Sound.play(SoundBundles.hitEntity)
	Effects.Entity.playHitAnim(playerSprite, Color.RED)

	if health <= 0:
		healthStatus = HealthStatus.DEAD


func takeHeal(heal: int) -> void:
	setHealth(min(health + heal, maxHealth))
	healTaken += heal

	#playHealEffect()
	updateHealthStatus()


func updateHealthStatus() -> void:
	if health == maxHealth:
		healthStatus = HealthStatus.FULL
		return

	var healthPercent := float(health) / maxHealth
	if healthPercent <= lowHealthThreshold:
		healthStatus = HealthStatus.LOW
	else:
		healthStatus = HealthStatus.NORMAL


func addCrystal(amount: int) -> void:
	crystals += amount
	GLogger.log("Player: Added %d crystals" % amount)

	levelProgress += amount
	if levelProgress >= levelRequired:
		levelUp()


func levelUp() -> void:
	level += 1
	levelProgress = 0
	updateLevelReq()
	
	GLogger.log("Player: Level up to %d" % level)


func updateLevelReq() -> void:
	@warning_ignore("narrowing_conversion")
	levelRequired = int(firstLevelReq * pow(levelReqMultiplier, level))


func setCameraZoom() -> void:
	camera.zoom = Vector2(defCamZoom + cameraZoomOffset, defCamZoom + cameraZoomOffset)
