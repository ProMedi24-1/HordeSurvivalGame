class_name WaveSpawner extends Node
## Class for spawning waves of enemies.

# Type of enemies that can be spawned.
enum EnemyType {
	BAT_EV1,
	# BAT_EV2,
	# BAT_EV3,
	FUNGUS_EV1,
	FUNGUS_EV2,
	FUNGUS_EV3,
	RAT_EV1,
	EYE_EV1,
}

# Map of enemy types to their scene and rating.
static var enemy_types = {
	EnemyType.BAT_EV1: Pair.new(
		preload("res://content/entity/enemy/bat/bat_ev1.tscn"),
		10.0 # Enemy Rating
		),
	# EnemyType.BAT_EV2: Utils.Pair.new(
	# 	preload("res://content/entity/enemy/bat/bat_ev2.tscn"),
	# 	2.0 # Enemy Rating
	# 	),
	# EnemyType.BAT_EV3: Utils.Pair.new(
	# 	preload("res://content/entity/enemy/bat/bat_ev3.tscn"),
	# 	3.0 # Enemy Rating
	# 	),
	EnemyType.FUNGUS_EV1: Pair.new(
		preload("res://content/entity/enemy/fungus/fungus_ev1.tscn"),
		30.0
		),
	EnemyType.FUNGUS_EV2: Pair.new(
		preload("res://content/entity/enemy/fungus/fungus_ev2.tscn"),
		40.0
		),
	EnemyType.FUNGUS_EV3: Pair.new(
		preload("res://content/entity/enemy/fungus/fungus_ev3.tscn"),
		70.0
		),
	EnemyType.RAT_EV1: Pair.new(
		preload("res://content/entity/enemy/rat/rat_ev1.tscn"),
		20.0
		),
	EnemyType.EYE_EV1: Pair.new(
		preload("res://content/entity/enemy/eye/eye_ev1.tscn"),
		50.0
		),
}

## Array of spawn points for enemies,
## placed in the editor.
static var spawn_points: Array = []

static var waveDuration: float = 60.0 ## Duration for one Wave in seconds
static var currentWave: int = 0 ## Current wave number


func _ready() -> void:
	set_spawn_points()

	var wave = Wave.new()
	add_child.call_deferred(wave)
	wave.start_wave()

## Fill the spawn_points array with all children of the WaveSpawner node.
func set_spawn_points() -> void:
	spawn_points = get_children()


## Spawn an enemy of the given type at a random spawn point.
## [type]: The type of enemy to spawn.
static func spawn_enemy(type: EnemyType) -> void:
	if spawn_points.size() == 0:
		return

	spawn_enemy_at(type, spawn_points[randi_range(0, spawn_points.size() - 1)].position)


## Spawn an enemy of the given type at the given position.
## [type]: The type of enemy to spawn.
## [pos]: The position to spawn the enemy at.
static func spawn_enemy_at(type: EnemyType, pos: Vector2) -> void:
	var enemy = enemy_types[type].first.instantiate()
	enemy.global_position = pos
	GSceneAdmin.scene_root.add_child.call_deferred(enemy)


## Wave Class for spawning enemies.
class Wave extends Node:
	var paused: bool = false ## Flag to pause the wave
	var spawn_interval: float = 2.0 ## Time between enemy spawns
	var spawn_timer: Timer

	var wave_running: bool = false


	# static var spawn_time_lookup = {
	# 	Pair.new(-INF, -20): 0.5,  # If the player rating is much higher than the enemy's, spawn quickly
	# 	Pair.new(-20, 0): 2,  # If the player rating is slightly higher, spawn a bit slower
	# 	Pair.new(0, 20): 5,  # If the player rating is slightly lower, spawn even slower
	# 	Pair.new(20, INF): 10  # If the player rating is much lower, spawn very slowly
	# }

	const spawn_time_lookup = {
		-20: 0.5,
		-10: 1.0,
		0: 2.0,
		10: 3.0,
		20: 4.0,
	}


	## Select an enemy to spawn based on player and enemy rating.
	## [return]: a pair of the enemy type and the time until the next spawn.
	func select_enemy_by_rating() -> Pair:
		var player_rating = GEntityAdmin.player.player_rating
		var possible_enemies = []

		# Iterate through all enemy types to find those suitable based on player rating
		for enemy_type in WaveSpawner.enemy_types.keys():
			var enemy_rating = WaveSpawner.enemy_types[enemy_type].second as float
			var rating_difference = player_rating - enemy_rating

			const rating_threshold = 10.0
			if abs(rating_difference) <= rating_threshold: # This threshold can be adjusted
				# Also adjust on rating the times the enemy is in the array
				#for i in range(0, 10 - abs(rating_difference) / 2):
				possible_enemies.append(enemy_type)

		# If no enemies are close enough in rating, just pick the lowest.
		if possible_enemies.is_empty():
			possible_enemies = WaveSpawner.enemy_types.keys()
			#var lowest_enemy: EnemyType = EnemyType.BAT_EV1

		# Select a random enemy from the filtered list
		var selected_enemy_type = possible_enemies[randi() % possible_enemies.size()]
		#var enemy_pair = WaveSpawner.enemy_types[selected_enemy_type]

		var next_spawn = func() -> float:
			var enemy_rating: float  = WaveSpawner.enemy_types[selected_enemy_type].second as float
			var rating_difference = player_rating - enemy_rating
			var spawn_time := 10.0


			# Find the spawn time based on the rating difference in our lookup table.
			for rating_range in spawn_time_lookup.keys():
				if rating_difference <= rating_range:
					spawn_time = spawn_time_lookup[rating_range]
					break

			print("Rating difference: ", rating_difference, "Spawn time: ", spawn_time)
			return spawn_time


		return Pair.new(selected_enemy_type, next_spawn.call())


	## Start the wave by spawning enemies
	func start_wave() -> void:
		spawn_enemies()

	## End the current wave by removing all enemies
	func end_wave() -> void:
		wave_running = false

		for enemies in GEntityAdmin.entities:
			if enemies is EnemyBase:
				enemies.queue_free()


	func spawn_enemies() -> void:
		var wave_timer = Timer.new()
		wave_timer.one_shot = true
		wave_timer.autostart = true
		wave_timer.wait_time = WaveSpawner.waveDuration

		wave_running = true

		wave_timer.connect("timeout", end_wave)
		add_child(wave_timer)

		spawn_timer = Timer.new()
		spawn_timer.one_shot = true
		spawn_timer.autostart = true
		spawn_timer.wait_time = 0.5 #spawn_interval
		add_child(spawn_timer)

		var spawn_func := func() -> void:
			print("spawning enemy")
			if not wave_running:
				return

			if not paused:
				var enemy := select_enemy_by_rating()

				WaveSpawner.spawn_enemy(enemy.first)
				spawn_timer.wait_time = enemy.second
				spawn_timer.start()

		spawn_timer.connect("timeout", spawn_func)
