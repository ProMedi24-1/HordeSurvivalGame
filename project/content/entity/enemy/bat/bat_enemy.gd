class_name BatEnemy extends EnemyBase
# BAT ENEMY


# Godot virtual functions
func _ready() -> void:
	super()

	movementMethod = func(delta) -> void:
		EnemyUtils.moveToPlayer(movBody, movSpeed, delta) 
	
	#Effects.Anim.playStdAnim(sprite, 4, 0.15, true)
	
	var defAnim = Effects.Anim.SpriteAnim.new(sprite, 5, 0.15)
	defAnim.looped = true
	defAnim.play()

static func spawn(pos: Vector2, evolution: int ) -> void:
	var evolutions = [
		load("res://content/entity/enemy/bat/bat_ev1.tscn"), 
		load("res://content/entity/enemy/bat/bat_ev2.tscn"), 
		load("res://content/entity/enemy/bat/bat_ev3.tscn")
		]

	var enemyInstance = evolutions[evolution].instantiate()

	enemyInstance.global_position = pos
	GSceneAdmin.levelBase.add_child(enemyInstance)

# Overriden functions
#func onDeath() -> void:
	#LootLibrary.spawnCrystal(self.global_position)
	#super()
	
