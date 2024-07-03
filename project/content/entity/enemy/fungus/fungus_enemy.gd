class_name FungusEnemy extends EnemyBase
# FUNGUS ENEMY


var movDir                = Vector2.RIGHT
var isCharging: bool      = false
var onCooldown: bool      = false
var chargeDistance: float = 100.0
var chargeSpeed: float    = 5000.0
var chargeTime: float     = 1.0
var cooldownTime: float   = 3.0
var org_movSpeed: float

var chargeTimer: Timer
var cooldownTimer: Timer


# Godot virtual functions
func _ready() -> void:
	super()

	org_movSpeed = movSpeed

	movementMethod = func(delta) -> void:
		chargeToPlayer(delta)

	chargeTimer = Timer.new()
	chargeTimer.wait_time = chargeTime
	chargeTimer.one_shot = true
	chargeTimer.connect("timeout", endCharge)
	add_child(chargeTimer)

	cooldownTimer = Timer.new()
	cooldownTimer.wait_time = cooldownTime
	cooldownTimer.one_shot = true
	cooldownTimer.connect("timeout", endCooldown)
	add_child(cooldownTimer)

func endCharge() -> void:
	isCharging = false
	onCooldown = true
	cooldownTimer.start()

func endCooldown() -> void:
	onCooldown = false


func chargeToPlayer(delta) -> void:
	var player := GEntityAdmin.player
	if player == null:
		return

	
	
	EnemyUtils.moveToDirection(movBody, movDir, movSpeed, delta)

	if onCooldown or global_position.distance_to(player.global_position) > chargeDistance:
		if not isCharging:
			movDir = global_position.direction_to(player.global_position)
			movSpeed = org_movSpeed
	else:
		if not isCharging:
			isCharging = true
			movDir = global_position.direction_to(player.global_position)
			movSpeed = chargeSpeed
			chargeTimer.start()
			
# Overriden functions
func onDeath() -> void:
	#LootLibrary.spawnCrystal(self.global_position)

	#CrystalSmall.spawn(global_position)
	super()
	
