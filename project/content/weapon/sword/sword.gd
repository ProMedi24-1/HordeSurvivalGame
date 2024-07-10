class_name Sword extends WeaponBase
## Sword weapon.

@export var proj_scene: PackedScene  ## The projectile scene to spawn.
@export var weapon_range: Area2D  ## The range of the weapon.


func _ready() -> void:
	super()
	self.name = "Sword"

	cooldown_time = 0.7
	cooldown = create_tween()
	cooldown.set_loops()
	cooldown.tween_callback(attack).set_delay(cooldown_time)


func attack() -> void:
	var target = WeaponUtils.get_closest_enemy(self, weapon_range)

	if target == null:
		return

	var projectile := proj_scene.instantiate()
	GSceneAdmin.scene_root.add_child(projectile)
	projectile.damage = 5
	projectile.scale = Vector2(1.3, 1.3)

	# Add offset to the projectile
	var direction = global_position.direction_to(target.global_position)
	projectile.global_position = self.global_position + direction * 25
	projectile.rotation = direction.angle()
