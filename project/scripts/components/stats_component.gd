class_name StatsComponent
extends Node2D

@export_category("Health")
@export var max_health: int = 100 ## The maximum health of the entity.
@export var health: int = 100 ## The current health of the entity.

## The threshold at which the health is considered low in percent.
@export_range(0, 100) var low_health_threshold: int = 20

@export var can_overheal: bool = false ## Whether the entity can overheal over the max health.

@export_category("Movement")
@export var max_movement_speed: int = 6000 ## The maximum movement speed of the entity.
@export var movement_speed: int = 6000 ## The current movement speed of the entity.

