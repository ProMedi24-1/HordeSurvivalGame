class_name Effects
extends Object

# This class gives helper functions to easily
# play animations and sound effects.

static func playSound(sound: AudioStream, randPitch: bool=false, randRange: Vector2=Vector2(0.9, 1.1)) -> void:
	var audioPlayer := AudioStreamPlayer.new()
	GGameGlobals.instance.add_child(audioPlayer)
	audioPlayer.stream = sound

	if randPitch:
		audioPlayer.pitch_scale = randf_range(randRange.x, randRange.y)

	audioPlayer.play()

	await audioPlayer.finished
	audioPlayer.queue_free()

static func playStdAnim(node: Object, sprite: Sprite2D, frameCount: int, speed: float, loop: bool) -> void:
	var tween = node.create_tween()

	if loop:
		tween.set_loops()

	var advanceFrame = func() -> void:
		sprite.frame += 1

		if sprite.frame >= frameCount:
			sprite.frame = 0

	tween.tween_callback(advanceFrame).set_delay(speed)

static func customTweenProperty(node: Object, target: Node, property: String, value: Variant, duration: float, reset: bool) -> void:
	var tween = node.create_tween()
	var orgVal = target.get(property)

	tween.tween_property(target, property, value, duration).set_trans(Tween.TRANS_LINEAR).from_current()

	var resetFunc = func() -> void:
		target.set(property, orgVal)

	if reset:
		tween.tween_callback(resetFunc)

static func addDamageNumbers(node, amount: int, crit: bool=false) -> void:
	var dmgNum := preload ("res://content/effects/damage_numbers/DamageNumbers.tscn").instantiate()
	dmgNum.text = str(amount)

	GSceneAdmin.sceneRoot.add_child(dmgNum)
	dmgNum.global_position = node.global_position + randf_range( - 20, 20) * Vector2(1, 1)

	if crit:
		dmgNum.modulate = Color.RED

	var tween := dmgNum.create_tween()
	tween.tween_property(dmgNum, "modulate:a", 0.0, 0.5)
	tween.tween_callback(dmgNum.queue_free)

static func playHitAnim(sprite, defColor, hitColor) -> void:
	var tween = sprite.create_tween()
	#tween.tween_property(sprite, "modulate", defColor, 0.1)
	tween.tween_property(sprite, "modulate", hitColor, 0.2)

	var resetFunc = func() -> void:
		sprite.modulate = defColor

	tween.tween_callback(resetFunc)

static func playCameraShake(strength: float) -> void:
	pass
