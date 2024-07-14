class_name SpawnEffect extends Node2D

signal spawn

@export var sprite: Sprite2D



func _ready() -> void:
	var std_anim = Anim.SpriteAnim.new(sprite, 5, 0.2)
	#std_anim.looped = true
	std_anim.play()
	Sound.play_sfx_ambient(global_position, Sound.Fx.SPAWN_ENEMY, 10.0, 1.2)

	await std_anim.finished
	spawn.emit()
	self.queue_free()

