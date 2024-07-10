class_name Sound
## Sound class for playing sound effects and music.


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


# TODO: Implement music playing.
## Plays a music track.
## [music]: The AudioStream to play.
#static func play_music(music: AudioStream) -> void:
# pass


## Class managing Sound Effects.
class Fx:
	## UI
	const CLICK = preload("res://assets/ui/button/click.ogg")
	const HOVER = preload("res://assets/ui/button/hover2.ogg")

	## Entity
	const HIT_ENTITY = preload("res://assets/entity/hitEntityA.wav")

	## Pickups
	const PICKUP_CRYSTAL = preload("res://assets/pickup/crystal/pickupCrystalA.wav")


## Class managing Music.
class Music:
	#const MAIN_MENU = preload("res://assets/music/main_menu.ogg")
	pass
