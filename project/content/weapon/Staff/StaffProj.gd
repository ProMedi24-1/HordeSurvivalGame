class_name StaffProj
extends Node2D

var speed: float = 200.0
var direction: Vector2 = Vector2.RIGHT
@onready var hitbox = $HitBox

func _ready() -> void:
	hitbox.connect("body_entered", onHit)

func onHit(body) -> void:
	if body is EnemyBase:
		body.takeDamage(10)

	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
