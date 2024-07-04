class_name Effects
## Helper class for common effects such as tween animations, sounds, etc.


class Sound:
	## Plays a random sound from a sound bundle. The AudioPlayer deletes itself once finished.
	## Also can take in a modifier function to e.g. change pitch, volume...
	static func play(soundBundle: Array, pitch: float = 1.0, modifier: Callable = Callable()) -> void:
		var audioPlayer := AudioStreamPlayer.new()
		GSceneAdmin.sceneRoot.add_child(audioPlayer)

		audioPlayer.bus = "SFX"
		audioPlayer.stream = soundBundle[randi_range(0, soundBundle.size() - 1)]
		audioPlayer.pitch_scale = pitch

		if not modifier.is_null():
			modifier.call(audioPlayer)

		audioPlayer.play()
		await audioPlayer.finished
		audioPlayer.queue_free()
		
	# Preset sound modifiers.
	## Modifies the pitch of the sound in a given range.
	static func modRandPitch(audioPlayer: AudioStreamPlayer, rangePitch: Vector2=Vector2(0.9, 1.1)) -> void:
		audioPlayer.pitch_scale = randf_range(rangePitch.x, rangePitch.y)

	## Modifies the volume of the sound in a given range.
	static func modRandVolume(audioPlayer: AudioStreamPlayer, rangeVol: Vector2=Vector2(0.7, 1.0)) -> void:
		audioPlayer.volume_db = linear_to_db(randf_range(rangeVol.x, rangeVol.y))
	

class Anim:
	## Plays a standard animation on a Sprite2D.
	class SpriteAnim:
		var sprite: Sprite2D
		#var frame: int = 0
		var frameCount: int = 0
		var speedScale: float = 0.0
		var paused: bool = false
		var looped: bool = false
		var tween: Tween
		var callbacker : CallbackTweener

		signal finished

		func _init(_sprite: Sprite2D, _frameCount: int, _speedScale: float = 1.0) -> void:
			self.sprite = _sprite
			self.frameCount = _frameCount
			self.speedScale = _speedScale

		func play() -> void:
			tween = sprite.create_tween()
			
			
			tween.set_loops()

			if not paused:
				callbacker = tween.tween_callback(advanceFrame).set_delay(speedScale)

		func advanceFrame() -> void:
			if sprite.frame >= (frameCount - 1):
				if looped:
					sprite.frame = 0
					finished.emit()
				else:
					finished.emit()
					return
			else: 
				sprite.frame += 1
		
		func toFrame(_frame: int) -> void:
			sprite.frame = _frame
			
		func setSpeed(_speedScale: float) -> void:
			#tween.kill()
			#tween = sprite.create_tween()
			#tween.set_loops()
			callbacker.set_delay(_speedScale)
			#if not paused:
				#tween.tween_callback(advanceFrame).set_delay(_speedScale)

	class TweenProperty:
		var tween: Tween
		var node: Node
		var property: String
		var targetValue: Variant
		var speedScale: float

		var orgValue: Variant
		var onFinish: Callable

		func _init(_node: Node, _property: String, _targetValue: Variant, _speedScale: float) -> void:
			self.node = _node
			self.tween = _node.create_tween()
			self.property = _property
			self.targetValue = _targetValue
			self.speedScale = _speedScale
			self.orgValue = node.get(property)

		func play() -> void:
			tween.tween_property(node, property, targetValue, speedScale)

			if onFinish.is_valid():
				tween.tween_callback(onFinish)

		func reset() -> void:
			node.set(property, orgValue)

		func destroy() -> void:
			reset()
			tween.kill()

		


class Camera:
	## Plays a little camera shake, usually on enemy hit.
	static func playCameraShake() -> void:
		var camera = GSceneAdmin.sceneRoot.get_viewport().get_camera_2d()

		if camera and LocalSettings.cameraShake:
			var tween = camera.create_tween()
			var tween2 = camera.create_tween()

			tween.tween_property(camera, "rotation", randf_range(-0.01, 0.01), 0.05)
			tween2.tween_property(camera, "offset", 
				Vector2(randf_range(-0.01, 0.01), 
						randf_range(-0.01, 0.01)), 
						0.05)

			tween.tween_property(camera, "rotation", 0, 0.05)
			tween2.tween_property(camera, "offset", Vector2.ZERO, 0.05)
			

class Entity:
	## Plays a hit animation (glowing red) on a Node2D.
	static func playHitAnim(node: Node2D, hitColor: Color) -> void:

		var dmgFx := preload ("res://content/effects/damage/damage_fx.tscn").instantiate()
		GSceneAdmin.sceneRoot.add_child(dmgFx)
		dmgFx.global_position = node.global_position

		var tween = Anim.TweenProperty.new(node, "modulate", hitColor, 0.2)
		tween.onFinish = tween.reset
		tween.play()
	

	static func addDamageNumbers(node, amount: int, crit: bool=false) -> void:
		
		var dmgNum := preload ("res://content/effects/damage/damage_numbers.tscn").instantiate()
		dmgNum.text = str(amount)

		GSceneAdmin.sceneRoot.add_child(dmgNum)
		dmgNum.global_position = node.global_position + randf_range(-20, 20) * Vector2(1, 1)

		if crit:
			dmgNum.modulate = Color.RED

		var tween := dmgNum.create_tween()
		tween.tween_property(dmgNum, "modulate:a", 0.0, 0.5)
		tween.tween_callback(dmgNum.queue_free)
