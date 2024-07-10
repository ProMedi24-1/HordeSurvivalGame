class_name BatEnemy extends EnemyBase
## Bat enemy as a flyer, has 3 evolutions.

func _ready() -> void:
	super()
	self.name = "BatEnemy"

	# Set movement to basic move to player.
	movement_method = func(delta) -> void:
		EnemyUtils.move_to_player(mov_body, mov_speed, delta)

	var std_anim = Anim.SpriteAnim.new(sprite, 5, 0.15)
	std_anim.looped = true
	std_anim.play()
