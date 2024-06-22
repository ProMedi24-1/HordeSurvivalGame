extends EnemyBase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	movementMethod = moveToPlayer
	
	Effects.playStdAnim(self, sprite, 4, 0.15, true)

func onDeath() -> void:
	print("bat died")
	LootLibrary.spawnCrystal(self.global_position)
	super()
