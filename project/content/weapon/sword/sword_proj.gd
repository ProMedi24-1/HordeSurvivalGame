class_name SwordProj extends Node2D

#var speed: float = 200.0
var direction: Vector2 = Vector2.RIGHT
var damage: int = 5

@onready var sprite = $Sprite2D
@onready var hitbox = $HitBox

func _ready() -> void:
	hitbox.connect("body_entered", onHit)
	var defAnim = Effects.Anim.SpriteAnim.new(sprite, 9, 0.15)
	defAnim.play()
	defAnim.connect("finished", animFinished)

	#self.rotation = direction.angle()

func animFinished() -> void:
	self.queue_free()

func onHit(body) -> void:

	var enemy = WeaponUtils.getEnemyNode(body)
	if enemy is EnemyBase and enemy != null:
		enemy.takeDamage(damage)
