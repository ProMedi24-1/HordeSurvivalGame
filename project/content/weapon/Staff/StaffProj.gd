class_name StaffProj extends Node2D

var speed: float = 200.0
var direction: Vector2 = Vector2.RIGHT
var damage: int = 5

@onready var hitbox = $HitBox

func _ready() -> void:
	hitbox.connect("body_entered", onHit)

func onHit(body) -> void:

	var enemy = WeaponUtils.getEnemyNode(body)
	if enemy is EnemyBase and enemy != null:
		enemy.takeDamage(damage)

	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
