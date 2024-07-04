extends FungusEnemy
# Evolution 1 of FUNGUS ENEMY

# Set the stats here.
func _init() -> void:
	health        = 100
	movSpeed      = 1400.0

	chargeDistance = 2500.0
	chargeSpeed   = 6000.0
	chargeTime    = 1.5

	meleeDamage   = 8
	meleeCooldown = 0.8

var defAnim	

func _ready() -> void:
	super()
	
	defAnim = Effects.Anim.SpriteAnim.new(sprite, 16, 0.06)

	defAnim.looped = true
	defAnim.play()

# This is awful, but i dont care currently.
func _process(_delta) -> void:
	
	#print(sprite.frame)
	if isCharging:
		defAnim.setSpeed(0.02)
	else:
		defAnim.setSpeed(0.06)
