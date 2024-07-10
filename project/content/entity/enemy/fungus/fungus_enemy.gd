class_name FungusEnemy extends EnemyBase
# Fungus enemy as a charger, has 3 evolutions.

var mov_dir: Vector2 = Vector2.RIGHT
var is_charging: bool = false
var on_cooldown: bool = false
var charge_distance: float = 100.0
var charge_speed: float = 5000.0
var charge_time: float = 1.0
var cooldown_time: float = 3.0
var org_mov_speed: float

var charge_timer: Timer
var cooldown_timer: Timer


func _ready() -> void:
	super()
	self.name = "FungusEnemy"

	org_mov_speed = mov_speed

	movement_method = func(delta) -> void: charge_to_player(delta)
	charge_timer = Timer.new()
	charge_timer.wait_time = charge_time
	charge_timer.one_shot = true
	charge_timer.connect("timeout", end_charge)
	add_child(charge_timer)

	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.one_shot = true
	cooldown_timer.connect("timeout", end_cooldown)
	add_child(cooldown_timer)


func end_charge() -> void:
	is_charging = false
	on_cooldown = true
	cooldown_timer.start()


func end_cooldown() -> void:
	on_cooldown = false


func charge_to_player(delta) -> void:
	var player := GEntityAdmin.player
	if player == null:
		return

	EnemyUtils.move_to_direction(mov_body, mov_dir, mov_speed, delta)

	if on_cooldown or global_position.distance_to(player.global_position) > charge_distance:
		if not is_charging:
			mov_dir = global_position.direction_to(player.global_position)
			mov_speed = org_mov_speed

	else:
		if not is_charging:
			is_charging = true
			mov_dir = global_position.direction_to(player.global_position)
			mov_speed = charge_speed

			charge_timer.start()
