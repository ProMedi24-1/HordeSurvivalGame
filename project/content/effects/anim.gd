class_name Anim
## Anim class for common effects such as tween animations, sounds, etc.


## Plays a standard animation on a Sprite2D.
class SpriteAnim:
	signal finished

	var sprite: Sprite2D
	var frame_count: int = 0
	var speed_scale: float = 0.0
	var paused: bool = false
	var looped: bool = false
	var playing: bool = false
	var tween: Tween
	var callbacker: CallbackTweener

	func _init(_sprite: Sprite2D, _frame_count: int, _speed_scale: float = 1.0) -> void:
		sprite = _sprite
		frame_count = _frame_count
		speed_scale = _speed_scale

	func play() -> void:
		if tween == null:
			tween = sprite.create_tween()
		#tween = sprite.create_tween()

		tween.set_loops()

		if not paused:
			callbacker = tween.tween_callback(advance_frame).set_delay(speed_scale)
			playing = true

	func stop() -> void:
		if tween != null:
			tween.kill()
			tween = null
			playing = false

	func advance_frame() -> void:
		if sprite.frame >= (frame_count - 1):
			if looped:
				sprite.frame = 0
				finished.emit()
			else:
				finished.emit()
				return
		else:
			sprite.frame += 1

	func to_frame(_frame: int) -> void:
		sprite.frame = _frame

	func set_speed(_speed_scale: float) -> void:
		callbacker.set_delay(_speed_scale)


class TweenProperty:
	var tween: Tween
	var node: Node
	var property: String
	var target_value: Variant
	var speed_scale: float

	var org_value: Variant
	var on_finish: Callable

	func _init(_node: Node, _property: String, _target_value: Variant, _speed_scale: float) -> void:
		node = _node
		tween = _node.create_tween()
		property = _property
		target_value = _target_value
		speed_scale = _speed_scale
		org_value = node.get(property)

	func play() -> void:
		tween.tween_property(node, property, target_value, speed_scale)

		if on_finish.is_valid():
			tween.tween_callback(on_finish)

	func reset() -> void:
		node.set(property, org_value)

	func destroy() -> void:
		reset()
		tween.kill()
