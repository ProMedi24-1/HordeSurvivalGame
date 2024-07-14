class_name Staff extends WeaponBase
## Staff weapon.

@export var proj_scene: PackedScene  ## The projectile scene to spawn.
@export var weapon_range: Area2D  ## The range of the weapon.

var cooldown_timer: Timer

func _ready() -> void:
	super()
	self.name = "Staff"

	weapon_name = "Staff"


	#cooldown_time = GEntityAdmin.player.attack_speed
	#cooldown = create_tween()
	#cooldown.set_loops()
	#cooldown.tween_callback(attack).set_delay(cooldown_time)
	cooldown_timer = Timer.new()
	cooldown_timer.set_wait_time(GEntityAdmin.player.attack_speed)
	cooldown_timer.set_one_shot(false)
	cooldown_timer.connect("timeout", attack)
	add_child(cooldown_timer)
	cooldown_timer.start()

func _process(_delta: float) -> void:
	if GEntityAdmin.player == null:
		return

	if cooldown_timer:
		cooldown_timer.set_wait_time(GEntityAdmin.player.attack_speed)



func attack() -> void:
	var target := WeaponUtils.get_closest_enemy(self, weapon_range)

	if target == null:
		return

	if GEntityAdmin.player.global_position.distance_to(target.global_position) > 200:
		return

	var projectile := proj_scene.instantiate()
	GSceneAdmin.scene_root.add_child(projectile)
	projectile.damage = damage

	var direction = global_position.direction_to(target.global_position)
	projectile.global_position = self.global_position + direction * 10

	projectile.direction = direction
