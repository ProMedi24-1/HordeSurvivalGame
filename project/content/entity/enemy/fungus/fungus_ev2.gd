extends FungusEnemy
# Evolution 1 of FUNGUS ENEMY

# Set the stats here.
func _init() -> void:
	health        = 50
	movSpeed      = 1300.0

	chargeDistance = 200.0
	chargeSpeed   = 5500.0
	chargeTime    = 2.0

	meleeDamage   = 8
	meleeCooldown = 0.8

var defAnim	

func _ready() -> void:
	super()
	
	defAnim = Effects.Anim.SpriteAnim.new(sprite, 8, 0.13)

	defAnim.looped = true
	defAnim.play()

# This is awful, but i dont care currently.
func _process(_delta) -> void:
	
	#print(sprite.frame)
	if isCharging:
		defAnim.setSpeed(0.05)
	else:
		defAnim.setSpeed(0.15)
