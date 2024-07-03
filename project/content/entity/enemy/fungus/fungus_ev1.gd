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
