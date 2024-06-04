class_name Enemy
extends CharacterBody2D

@onready var stats_component = $StatsComponent

func get_collision_damage():
	return stats_component.collision_damage
