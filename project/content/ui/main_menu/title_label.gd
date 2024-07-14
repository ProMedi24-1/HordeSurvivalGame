extends Sprite2D

func _ready() -> void:
	var std_anim = Anim.SpriteAnim.new(self, 13, 0.2)
	std_anim.play()


