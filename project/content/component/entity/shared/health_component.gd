class_name HealthComponent
extends Node2D

signal health_changed()
signal healed(amount:float)
signal damaged(amount:float)

signal died

@export var stats: StatsComponent ## The node that handles the entity stats.

func set_health(new_health: int):
	stats.health = new_health
	health_changed.emit()


func take_damage(amount):
	#stats.health = (max(stats.health - amount, 0))

	set_health(max(stats.health - amount, 0))

	damaged.emit(amount)

	if stats.health <= 0:
		died.emit()
	

func take_heal(amount):
	
	if "can_overheal" in stats:
		if stats.can_overheal: 
			set_health(stats.health + amount)

	set_health(min(stats.health + amount, stats.max_health))
	healed.emit(amount)


func is_full_health() -> bool:
	return stats.health >= stats.max_health


func is_low_health() -> bool:
	return stats.health <= stats.low_health_threshold

