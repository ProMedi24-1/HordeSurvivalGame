extends Node2D

@export var sprite: Sprite2D

func _ready() -> void:
	var std_anim = Anim.SpriteAnim.new(sprite, 4, 0.05)
	#std_anim.looped = true
	std_anim.play()
	Sound.play_sfx_ambient(global_position, Sound.Fx.DEATH_ENEMY, 10.0, 1.2)

	await std_anim.finished
	self.queue_free()
