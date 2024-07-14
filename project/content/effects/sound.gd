class_name Sound
## Sound class for playing sound effects and music.

static var music_player: AudioStreamPlayer = null
static var music_looped: bool = true

## Plays a sound Effect by creating an AudioPlayer, that frees itself after playing.
## [sound]: The AudioStream to play.
## [pitch]: The pitch of the sound.
## [volume]: The volume of the sound.
static func play_sfx(sound: AudioStream, pitch: float = 1.0, volume: float = 1.0) -> void:
	var audio_player := AudioStreamPlayer.new()
	audio_player.bus = "SFX"
	audio_player.stream = sound
	audio_player.pitch_scale = pitch
	audio_player.volume_db = linear_to_db(volume)

	GSceneAdmin.scene_root.add_child(audio_player)

	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()

static func play_sfx_ambient(pos: Vector2, sound: AudioStream, attenuation: float,
								pitch: float = 1.0, volume: float = 1.0) -> void:
	var audio_player := AudioStreamPlayer2D.new()
	audio_player.bus = "SFX"
	audio_player.stream = sound
	audio_player.pitch_scale = pitch
	audio_player.volume_db = linear_to_db(volume)
	audio_player.attenuation = attenuation
	audio_player.max_distance = 1000

	audio_player.global_position = pos
	GSceneAdmin.scene_root.add_child(audio_player)

	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()


# TODO: Implement music playing.
## Plays a music track.
## [music]: The AudioStream to play.
static func play_music(music: AudioStream) -> void:
	if music_player == null:
		music_player = AudioStreamPlayer.new()
		music_player.bus = "Music"

		music_player.volume_db = linear_to_db(0.1)
		GGameGlobals.instance.add_child(music_player)

	if music == music_player.stream:
		return

	music_player.stream = music
	music_player.play()

	if music_looped:
		await music_player.finished
		play_music(music)

static func transition_music(new_music: AudioStream) -> void:
	if music_player == null:
		return

	# Use tweens to fade out the current music and fade in the new music.
	var org_db = music_player.volume_db

	var fade_out_tween = GGameGlobals.instance.create_tween()
	fade_out_tween.tween_property(music_player, "volume_db", -80, 1.0)
	await fade_out_tween.finished
	fade_out_tween.kill()

	music_player.stream = new_music
	music_player.play()

	fade_out_tween.tween_property(music_player, "volume_db", org_db, 1.0)




## Class managing Sound Effects.
class Fx:
	## UI
	const CLICK = preload("res://assets/ui/button/click.ogg")
	const HOVER = preload("res://assets/ui/button/hover2.ogg")
	const BREWING_BOTTLE = preload("res://assets/ui/brewing_bottle.wav")
	const FINISH_WAVE = preload("res://assets/ui/wave_completed.wav")

	## Entity
	const HIT_ENTITY = preload("res://assets/entity/hitEntityA.wav")
	const SPAWN_ENEMY = preload("res://assets/entity/enemy/spawn_ring.wav")
	const DEATH_ENEMY = preload("res://assets/entity/enemy/enemy_death.wav")

	const HIT_PLAYER = preload("res://assets/entity/player/hit_player.wav")
	const DEATH_PLAYER = preload("res://assets/entity/player/death_player.wav")

	## Pickups
	const PICKUP_CRYSTAL = preload("res://assets/pickup/crystal/pickupCrystalA.wav")

	## Weapons
	const SHOOT_STAFF = preload("res://assets/weapons/staff/staff_shoot.wav")




## Class managing Music.
class Music:
	const MAIN_MENU = preload("res://assets/music/main_menu.mp3")
	const COMBAT_STAGE1 = preload("res://assets/music/combat_stage1.mp3")
	const COMBAT_STAGE2 = preload("res://assets/music/combat_stage2.mp3")
	const COMBAT_STAGE3 = preload("res://assets/music/combat_stage3.mp3")
