class_name EnemyBase extends Node2D
## Base Class which all enemies inherit from.


# Member Variables
var health: int     = 100
var movSpeed: float = 2000.0

var meleeDamage: int     = 5
var meleeCooldown: float = 0.3
var cooldown: Tween
var playerTouching: bool = false

#var lootBundle: Utils.Pair = Utils.Pair.new(1, 1)

var movementMethod: Callable


# Linkable Nodes
@export var movBody: CharacterBody2D
@export var sprite: Sprite2D
@export var hitBox: Area2D


# Godot virtual functions
func _ready() -> void:
	GEntityAdmin.registerEntity(self)

	hitBox.connect("body_entered", onPlayerEnter)
	hitBox.connect("body_exited", onPlayerExit)

func _exit_tree() -> void:
	GEntityAdmin.unregisterEntity(self)

func _physics_process(delta: float) -> void:
	movementMethod.call(delta)
	movBody.move_and_slide()


# Custom functions
static func spawn(_pos: Vector2, _evolution: int) -> void:
	# Override
	pass


func takeDamage(damage: int) -> void:
	health -= damage

	Effects.Sound.play(SoundBundles.hitEntity)
	Effects.Entity.addDamageNumbers(self, damage, false)
	Effects.Entity.playHitAnim(sprite, Color.RED)
	Effects.Camera.playCameraShake()

	if health <= 0:
		onDeath()


func onDeath() -> void:
	# TODO: Spawn crystals & ingredients on death.

	if GEntityAdmin.player:
		GEntityAdmin.player.kills += 1

	# TODO: Play death animation.
	self.get_parent().queue_free()


func onPlayerEnter(body: Node2D) -> void:
	if body != GEntityAdmin.player:
		return

	playerTouching = true

	var doDamage := func() -> void:
		GEntityAdmin.player.takeDamage(meleeDamage)

	doDamage.call()
	cooldown = create_tween()
	cooldown.set_loops()
	cooldown.tween_callback(doDamage).set_delay(meleeCooldown)


func onPlayerExit(body: Node2D) -> void:
	if body != GEntityAdmin.player:
		return

	playerTouching = false
	cooldown.kill()
