class_name Weapon
extends Node2D

@export var cooldown: float = 0.5
@export var damage: int = 50

func damage_area_entered(body: Node2D):
	print(body)
	pass
