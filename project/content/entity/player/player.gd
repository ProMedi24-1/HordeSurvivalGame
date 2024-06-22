class_name Player
extends EntityBase

enum HealthStatus {
	FULL,
	NORMAL,
	LOW,
	DEAD,
}

@export
var maxHealth: int = 100
@export
var health: int = maxHealth
@export
var godMode: bool = false
var healthStatus: HealthStatus = HealthStatus.FULL
const lowHealthThreshold: float = 0.25

@export
var movSpeed: float = 5000.0

# Level and weapons.
@export
var crystals: int = 0
var level: int = 0
var levelProgress: int = 0
var firstLevelReq: int = 25
var levelRequired: int = firstLevelReq
var levelReqMultiplier: float = 1.3

var weaponInventory: Array = []

# Various stats
var kills: int = 0
var damageTaken: int = 0
var healTaken: int = 0

# Nodes
@export
var movBody: CharacterBody2D
@export
var playerSprite: Sprite2D

# Animations
@export
var effectAnimPlayer: AnimationPlayer
@export
var effectAudioPlayer: AudioStreamPlayer

var hitSound := preload ("res://assets/audio/effects/hitPlayer.wav")
#var healSound := preload ("res://assets/audio/effects/healPlayer.wav")

@export
var hudRes: PackedScene = preload ("res://content/ui/hud/Hud.tscn")

func _ready() -> void:
	super()

	add_child(hudRes.instantiate())
	GLogger.log("Player: Ready", Color.AQUA)

func _physics_process(delta: float) -> void:
	if movBody == null:
		return
	
	handlePlayerMovement(delta)
	movBody.move_and_slide()

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

	GLogger.log("Player: Took %d damage" % damage)
	#playDamageEffect()
	Effects.playSound(hitSound)
	Effects.playHitAnim(playerSprite, Color.WHITE, Color.RED)

	if health <= 0:
		healthStatus = HealthStatus.DEAD
	
func takeHeal(heal: int) -> void:
	setHealth(min(health + heal, maxHealth))
	healTaken += heal

	GLogger.log("Player: Took %d heal" % heal)
	playHealEffect()

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
	#levelRequired *= levelReqMultiplier
	levelRequired = int(firstLevelReq * pow(levelReqMultiplier, level))

func playDamageEffect() -> void:
	if effectAnimPlayer == null:
		return

	#effectAnimPlayer.play("damage")
	#if effectAudioPlayer != null:
		#effectAudioPlayer.stream = hitSound
		#effectAudioPlayer.pitch_scale = randf_range(0.9, 1.1)
		#effectAudioPlayer.play()

	Effects.playSound(hitSound)

	#await effectAnimPlayer.animation_finished
	#effectAnimPlayer.play("RESET")
	Effects.customTweenProperty(self, playerSprite, "modulate", Color.RED, 0.2, true)
	#var tween = self.create_tween()
	#tween.bind_node(self)
	#tween.tween_property(playerSprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_LINEAR)
	
	#tween.tween_callback(tween.kill)
	#var tween2 = self.create_tween()
	
	#tween2.tween_callback(tween.stop).set_delay(0.5)
	#tween.stop()
	#tween.set
	#tween.stop()
	#tween.kill()
	#tween.tween_callback($Sprite.queue_free)

func playHealEffect() -> void:
	if effectAnimPlayer == null:
		return

	effectAnimPlayer.play("heal", -1, 0.5)
	if effectAudioPlayer != null:
		effectAudioPlayer.stream = preload ("res://assets/audio/effects/fxHeal.ogg")
		effectAudioPlayer.pitch_scale = randf_range(0.9, 1.1)
		effectAudioPlayer.play()

	await effectAnimPlayer.animation_finished
	effectAnimPlayer.play("RESET")
