class_name WeaponArea2D
extends Area2D

@export var stats: WeaponStatsComponent

var cooldown = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

	cooldown.wait_time = stats.melee_cooldown
	cooldown.one_shot = false
	cooldown.connect("timeout", _check_colliding_enemies)
	add_child(cooldown)


func _on_body_entered(body: EntityBaseComponent) -> void:
	damage_body(body)
	cooldown.start()

func _on_body_exited(body: EntityBaseComponent) -> void:
	cooldown.stop()
		
func _check_colliding_enemies():
	for body in get_overlapping_bodies():
		damage_body(body)

func damage_body(body) -> void:
	# TODO set a type so all bodies have health
	body.health.take_damage(stats.melee_damage)
	GameGlobals.logger.log("Melee hurt body: " + str(stats.melee_damage) + " damage", Color.GREEN)
