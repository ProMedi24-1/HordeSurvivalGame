class_name SwordProj extends Node2D
## Sword projectile.

@export var sprite: Sprite2D  ## The sprite of the projectile.
@export var hitbox: Area2D  ## The hitbox for the projectile.

var direction: Vector2 = Vector2.RIGHT  ## The direction of the projectile.
var damage: int = 5  ## The damage of the projectile.


func _ready() -> void:
	self.name = "SwordProj"
	hitbox.connect("body_entered", on_hit)

	var std_anim = Anim.SpriteAnim.new(sprite, 9, 0.1)
	std_anim.play()
	std_anim.connect("finished", anim_finished)


## On sword animation finished.
func anim_finished() -> void:
	self.queue_free()


## On hit function.
## [body]: The body that was hit.
func on_hit(body) -> void:
	var enemy = WeaponUtils.get_enemy_node(body)
	if enemy is EnemyBase and enemy != null:
		enemy.take_damage(damage)
