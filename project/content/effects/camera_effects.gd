class_name CameraEffects
## Class for camera effects such as camera shake, zoom, etc.


## Plays a little camera shake, usually on enemy hit.
static func play_camera_shake() -> void:
	var camera = GSceneAdmin.scene_root.get_viewport().get_camera_2d()

	if camera and LocalSettings.camera_shake_enabled:
		var tween = camera.create_tween()
		var tween2 = camera.create_tween()

		tween.tween_property(camera, "rotation", randf_range(-0.01, 0.01), 0.05)
		tween2.tween_property(
			camera, "offset", Vector2(randf_range(-0.01, 0.01), randf_range(-0.01, 0.01)), 0.05
		)

		tween.tween_property(camera, "rotation", 0, 0.05)
		tween2.tween_property(camera, "offset", Vector2.ZERO, 0.05)
