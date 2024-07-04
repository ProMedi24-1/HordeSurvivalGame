class_name WeaponBase
extends Node2D

var level: int = 0


var damage: int = 10
var projectiles: int = 1
var attackSpeed: float = 1.0

var cooldownTime: float = 0.5
var cooldown: Tween

func _ready() -> void:
	pass

# Override
func attack() -> void:
	pass
