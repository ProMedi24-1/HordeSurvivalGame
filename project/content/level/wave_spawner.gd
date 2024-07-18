class_name WaveSpawner extends Node
## Class for spawning waves of enemies.

# Type of enemies that can be spawned.
enum EnemyType {
	BAT_EV1,
	BAT_EV2,
	BAT_EV3,
	FUNGUS_EV1,
	FUNGUS_EV2,
	FUNGUS_EV3,
	RAT_EV1,
	EYE_EV1,
	SKELETON_EV1,
	HOUND_EV1,
}

const WAVE_TIMES := {
	1: 30.0,
	3: 45.0,
	5: 60.0,
}


const WAVE_AMBIENCES = {
	1: LevelBase.LevelAmbience.NON_SPOOKY,
	10: LevelBase.LevelAmbience.HALF_SPOOKY,
	20: LevelBase.LevelAmbience.SPOOKY,
}

# Map of enemy types to their scene and rating.
static var enemy_types = {
	EnemyType.BAT_EV1: Pair.new(
		preload("res://content/entity/enemy/bat/bat_ev1.tscn"),
		10.0 # Enemy Rating
		),
	EnemyType.BAT_EV2: Pair.new(
		preload("res://content/entity/enemy/bat/bat_ev2.tscn"),
		30.0
		),
	EnemyType.BAT_EV3: Pair.new(
		preload("res://content/entity/enemy/bat/bat_ev3.tscn"),
		50.0
		),
	EnemyType.FUNGUS_EV1: Pair.new(
		preload("res://content/entity/enemy/fungus/fungus_ev1.tscn"),
		35.0
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
		23.0
		),
	EnemyType.EYE_EV1: Pair.new(
		preload("res://content/entity/enemy/eye/eye_ev1.tscn"),
		50.0
		),
	EnemyType.SKELETON_EV1: Pair.new(
		preload("res://content/entity/enemy/skeleton/skeleton_enemy.tscn"),
		60.0
		),
	EnemyType.HOUND_EV1: Pair.new(
		preload("res://content/entity/enemy/hound/hound_enemy.tscn"),
		90.0
		),
}

## Array of spawn points for enemies,
## placed in the editor.
static var spawn_points: Array = []

static var wave_duration: float = 60.0 ## Duration for one Wave in seconds
static var current_wave: int = 0 ## Current wave number
static var spawner_ref: WaveSpawner ## Reference to the WaveSpawner node
static var wave_ref: Wave ## Reference to the current wave
static var adaptive_difficulty: bool = false ## If the difficulty should adapt to the player rating


func _ready() -> void:
	self.name = "WaveSpawner"
	spawner_ref = self

	set_spawn_points()

	var wave = Wave.new()
	add_child.call_deferred(wave)
	current_wave = 0

	wave.start_wave()

	Sound.play_music(Sound.Music.COMBAT_STAGE1)

## Fill the spawn_points array with all children of the WaveSpawner node.
func set_spawn_points() -> void:
	spawn_points = get_children()


## Spawn an enemy of the given type at a random spawn point.
## [type]: The type of enemy to spawn.
static func spawn_enemy(type: EnemyType) -> void:
	if spawn_points.size() == 0:
		return

	spawn_enemy_at(type, spawn_points[randi() % spawn_points.size()].position)


## Spawn an enemy of the given type at the given position.
## [type]: The type of enemy to spawn.
## [pos]: The position to spawn the enemy at.
static func spawn_enemy_at(type: EnemyType, pos: Vector2) -> void:
	#print("Spawning enemy at: ", pos)
	var spawn_effect = preload("res://content/effects/enemy/spawn_effect.tscn").instantiate()
	spawn_effect.global_position = pos
	GSceneAdmin.scene_root.add_child.call_deferred(spawn_effect)

	await spawn_effect.spawn

	var enemy = enemy_types[type].first.instantiate()
	enemy.global_position = pos
	GSceneAdmin.scene_root.add_child.call_deferred(enemy)


## Wave Class for spawning enemies.
class Wave extends Node:

	const RATING_THRESHOLD := 17.0

	## Lookup table for spawn times based on the rating difference.
	## Spawn time in seconds
	# const SPAWN_TIME_LOOKUP = {
	# 	[-INF, -15]: 2.0,
	# 	[-15, -10]: 2.0,
	# 	[-10, -5]: 3.0,
	# 	[-5, 5]: 5.0,
	# 	[5, 10]: 7.0,
	# 	[10, 15]: 10,
	# 	[15, RATING_THRESHOLD]: 10.0,
	# }



	var wave_running: bool = false
	var wave_spawning: bool = true
	#var time_elapsed_wave: int = 0

	## Array of enemy candidates to spawn. Contains a Pair of the EnemyType and
	## the time to spawn the next of his type.
	var enemy_candidates: Array[Pair] = []

	var wave_timer: Timer

	static var spawn_time_lookup = {
		Pair.new(-INF, -15): 2.0,
		Pair.new(-15, -10): 2.1,
		Pair.new(-10, -5): 2.3,
		Pair.new(-5, 5): 2.5,
		Pair.new(5, 10): 6.0,
		Pair.new(10, 15): 10.0,
		Pair.new(15, RATING_THRESHOLD): 15.0
	}

	## Set up the enemy candidates for the wave.
	## The candidates are based on the player rating and the enemy rating.
	func setup_candidates() -> void:
		print("Setting up enemy candidates...")
		enemy_candidates = []

		for enemy_type in WaveSpawner.enemy_types.keys():
			var enemy_rating := WaveSpawner.enemy_types[enemy_type].second as float
			var rating_difference := enemy_rating - GEntityAdmin.player.player_rating

			var calculate_spawn_time = func() -> float:
				var spawn_time := 0.5

				# Set the spawn time by our lookup table.
				#for rating_range in SPAWN_TIME_LOOKUP.keys():
					#if rating_difference >= rating_range[0] and rating_difference < rating_range[1]:
						#spawn_time = SPAWN_TIME_LOOKUP[rating_range]
						#break

				for pair in spawn_time_lookup.keys():
					if rating_difference >= pair.first and rating_difference <= pair.second:
						spawn_time = spawn_time_lookup[pair]
						break


				return spawn_time

			# Append every enemy which is lower than the player rating
			#const RATING_THRESHOLD := 20.0
			if enemy_rating <= GEntityAdmin.player.player_rating + RATING_THRESHOLD:
				enemy_candidates.append(Pair.new(enemy_type, calculate_spawn_time.call()))

		for enemy in enemy_candidates:
			print("Enemy: ", WaveSpawner.EnemyType.keys()[enemy.first], " Time: ", enemy.second)

	func create_spawn_timers() -> void:
		print("creating spawn timers")

		for enemy in enemy_candidates:
			var enemy_type = enemy.first
			var spawn_time = enemy.second

			var spawn_timer = Timer.new()
			spawn_timer.one_shot = true
			spawn_timer.autostart = true
			spawn_timer.wait_time = spawn_time
			add_child(spawn_timer)

			var spawn_func = func() -> void:
				#print("spawning enemy")
				if not wave_running:
					#spawn_timer.stop()
					return

				if wave_spawning:
					WaveSpawner.spawn_enemy(enemy_type)
					spawn_timer.wait_time = spawn_time + randf_range(-0.5, 1)
					spawn_timer.start()

			spawn_timer.connect("timeout", spawn_func)




	func spawn_enemies() -> void:
		wave_timer = Timer.new()
		wave_timer.one_shot = true
		wave_timer.autostart = true
		wave_timer.wait_time = WaveSpawner.wave_duration

		wave_running = true

		wave_timer.connect("timeout", end_wave)
		add_child(wave_timer)

		setup_candidates()
		create_spawn_timers()

	## Start the wave by spawning enemies
	func start_wave() -> void:
		WaveSpawner.wave_ref = self

		GSceneAdmin.level_base.time_elapsed_wave = 0
		WaveSpawner.current_wave += 1

		# Set the wave duration based on the current wave. if its in the range
		# of the WAVE_TIMES dictionary.
		if WaveSpawner.current_wave < WAVE_TIMES.keys()[1]:
			WaveSpawner.wave_duration = WAVE_TIMES.values()[0]
		elif WaveSpawner.current_wave < WAVE_TIMES.keys()[2]:
			WaveSpawner.wave_duration = WAVE_TIMES.values()[1]
		else:
			WaveSpawner.wave_duration = WAVE_TIMES.values()[2]


		if WaveSpawner.current_wave < WAVE_AMBIENCES.keys()[1]:
			GSceneAdmin.level_base.change_ambience(WAVE_AMBIENCES.values()[0])
		elif WaveSpawner.current_wave < WAVE_AMBIENCES.keys()[2]:
			GSceneAdmin.level_base.change_ambience(WAVE_AMBIENCES.values()[1])
		else:
			GSceneAdmin.level_base.change_ambience(WAVE_AMBIENCES.values()[2])



		# Reset per player wave stats
		GEntityAdmin.player.damage_taken = 0
		GEntityAdmin.player.kills_in_wave = 0

		# Small spawn delay
		await WaveSpawner.spawner_ref.create_tween().tween_interval(2).finished
		#var tween = create_tween()
		#tween.tween_interval(2)
		#await tween.finished
		#tween.kill()

		spawn_enemies()

	## End the current wave by removing all enemies
	func end_wave() -> void:
		wave_running = false

		for enemies in GEntityAdmin.entities:
			if enemies is EnemyBase:
				enemies.die(false, false)

		# Remove all spawn effects
		for effect in GSceneAdmin.scene_root.get_children():
			if effect is SpawnEffect:
				effect.queue_free()

		# Clean up timers
		for timer in get_children():
			timer.queue_free()



		wave_timer = null

		await GSceneAdmin.scene_root.create_tween().tween_interval(1.4).finished


		GStateAdmin.pause_game(false)
		var upgrade_menu = load("res://content/ui/upgrade_menu/upgrade_menu.tscn").instantiate()
		GGameGlobals.instance.add_child(upgrade_menu)
		upgrade_menu.layer = 2

		if WaveSpawner.adaptive_difficulty:
			GEntityAdmin.player.update_player_rating(true)
		else:
			GEntityAdmin.player.update_player_rating(false, 4.0) # rating increase


