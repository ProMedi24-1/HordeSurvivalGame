class_name Staff extends WeaponBase
## Staff weapon.

@export var proj_scene: PackedScene  ## The projectile scene to spawn.
@export var weapon_range: Area2D  ## The range of the weapon.


func _ready() -> void:
	super()
	self.name = "Staff"

	weapon_name = "Staff"


	cooldown_time = 0.5
	cooldown = create_tween()
	cooldown.set_loops()
	cooldown.tween_callback(attack).set_delay(cooldown_time)


func attack() -> void:
	var target := WeaponUtils.get_closest_enemy(self, weapon_range)

	if target == null:
		return

	var projectile := proj_scene.instantiate()
	GSceneAdmin.scene_root.add_child(projectile)
	projectile.damage = damage

	var direction = global_position.direction_to(target.global_position)
	projectile.global_position = self.global_position + direction * 10

	projectile.direction = direction
