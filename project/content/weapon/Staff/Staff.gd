class_name Staff extends WeaponBase

@export var projScene: PackedScene
@export var weaponRange: Area2D

func _ready() -> void:
	super()
	#damage = 10
	cooldownTime = 0.5
	cooldown = create_tween()
	cooldown.set_loops()
	cooldown.tween_callback(attack).set_delay(cooldownTime)
	
func attack() -> void:
	var target = WeaponUtils.getClosestEnemy(self, weaponRange)

	if target == null:
		return

	var projectile := projScene.instantiate()
	GSceneAdmin.sceneRoot.add_child(projectile)
	projectile.damage = 5
	projectile.global_position = self.global_position


	#if target:
	projectile.direction = global_position.direction_to(target.global_position)
