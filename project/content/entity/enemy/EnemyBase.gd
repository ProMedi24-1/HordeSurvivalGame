class_name EnemyBase
extends EntityBase

@export
var health: int = 100

@export
var movSpeed: float = 2000.0

@export
var meleeDamage: int = 5
var meleeCooldown: float = 0.3

@export
var hitBox: Area2D

@export
var movBody: CharacterBody2D
@export
var sprite: Sprite2D

var movementMethod: Callable

var playerTouching: bool = false
var cooldown: Tween

func _ready() -> void:
	super()

	hitBox.connect("body_entered", onPlayerEnter)
	hitBox.connect("body_exited", onPlayerExit)

func _exit_tree() -> void:
	super()

func _physics_process(delta: float) -> void:
	movementMethod.call(delta)
	movBody.move_and_slide()

func moveToPlayer(delta: float) -> void:
	var player = GEntityAdmin.player
	if player == null or movBody == null:
		return

	var direction = Vector2.ZERO
	
	direction = movBody.global_position.direction_to(player.movBody.global_position)
	
	movBody.velocity = direction.normalized() * movSpeed * delta

func takeDamage(damage: int) -> void:
	health -= damage

	Effects.addDamageNumbers(self, damage)

	Effects.playSound(preload ("res://assets/audio/effects/hitEnemy.wav"), true)
	Effects.playHitAnim(sprite, Color.WHITE, Color.RED)

	if health <= 0:
		onDeath()

func onDeath() -> void:
	# TODO: Spawn Loot on Death

	if GEntityAdmin.player:
		GEntityAdmin.player.kills += 1
	self.queue_free()

func onPlayerEnter(body: Node2D) -> void:
	if body != GEntityAdmin.player:
		return

	playerTouching = true

	var doDamage = func() -> void:
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
