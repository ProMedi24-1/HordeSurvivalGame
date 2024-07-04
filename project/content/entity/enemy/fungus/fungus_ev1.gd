extends FungusEnemy
# Evolution 1 of FUNGUS ENEMY

# Set the stats here.
func _init() -> void:
	health        = 30
	movSpeed      = 1200.0

	chargeDistance = 100.0
	chargeSpeed   = 5000.0
	chargeTime    = 1.0

	meleeDamage   = 8
	meleeCooldown = 0.8
	
var defAnim	

func _ready() -> void:
	super()
	
	defAnim = Effects.Anim.SpriteAnim.new(sprite, 4, 0.15)

	defAnim.looped = true
	defAnim.play()

# This is awful, but i dont care currently.
func _process(_delta) -> void:
	if isCharging:
		defAnim.setSpeed(0.05)
	else:
		defAnim.setSpeed(0.15)
