class_name HealthComponent
extends Node2D

signal healed(amount:float)
signal damaged(amount:float)

signal died

@export var stats: StatsComponent ## The node that handles the entity stats.

func take_damage(amount):
	stats.set_health(max(stats.health-amount, 0))
	damaged.emit(amount)

	if stats.health <= 0:
		died.emit()

func take_heal(amount):
	stats.set_health(stats.health+amount)

	if not stats.can_overheal:
		stats.set_health(min(stats.health, stats.max_health))
	healed.emit(amount)

func is_full_health() -> bool:
	return stats.health == stats.max_health

func is_low_health() -> bool:
	return stats.health <= stats.low_health_threshold

