extends Node2D

@export var liquid_sprite: Sprite2D
@export var fire_sprite: Sprite2D

var liquid_anim: Anim.SpriteAnim
var fire_anim: Anim.SpriteAnim

func _ready() -> void:
	self.name = "Cauldron"

	liquid_anim = Anim.SpriteAnim.new(liquid_sprite, 4, 0.2)
	fire_anim = Anim.SpriteAnim.new(fire_sprite, 4, 0.2)

	liquid_anim.looped = true
	fire_anim.looped = true
	liquid_anim.play()
	fire_anim.play()
