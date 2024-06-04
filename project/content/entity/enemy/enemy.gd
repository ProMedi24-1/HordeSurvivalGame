class_name Enemy
extends CharacterBody2D

@onready var stats = $StatsComponent

func get_collision_damage():
	return stats.collision_damage
