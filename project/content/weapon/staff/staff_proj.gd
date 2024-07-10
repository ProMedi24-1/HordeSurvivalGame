class_name StaffProj extends Node2D
## Staff projectile.

@export var hitbox: Area2D  ## The hitbox for the projectile.

var speed: float = 200.0  ## The speed of the projectile.
var direction: Vector2 = Vector2.RIGHT  ## The direction of the projectile.
var damage: int = 5  ## The damage of the projectile.


func _ready() -> void:
	self.name = "StaffProj"
	hitbox.connect("body_entered", on_hit)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


## On hit function.
## [body]: The body that was hit.
func on_hit(body) -> void:
	var enemy = WeaponUtils.get_enemy_node(body)
	if enemy is EnemyBase and enemy != null:
		enemy.take_damage(damage)

	queue_free()
