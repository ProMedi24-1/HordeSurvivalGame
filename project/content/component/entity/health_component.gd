class_name HealthComponent
extends Node2D

signal health_changed(new_health: int)
signal healed(amount:float)
signal damaged(amount:float)

signal died

@export var stats: StatsComponent ## The node that handles the entity stats.

func set_health(new_health: int):
	stats.health = new_health
	health_changed.emit(new_health)

func take_damage(amount):
	stats.set_health(max(stats.health-amount, 0))
	damaged.emit(amount)

	if stats.health <= 0:
		died.emit()
	
	health_changed.emit(stats.health - amount)

func take_heal(amount):
	stats.set_health(stats.health+amount)

	if not stats.can_overheal:
		stats.set_health(min(stats.health, stats.max_health))
	healed.emit(amount)

	health_changed.emit(stats.health + amount)

func is_full_health() -> bool:
	return stats.health >= stats.max_health

func is_low_health() -> bool:
	return stats.health <= stats.low_health_threshold

