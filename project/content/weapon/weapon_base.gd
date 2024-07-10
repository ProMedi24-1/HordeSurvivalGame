class_name WeaponBase extends Node2D
## Base class for all weapons.

var texture_menu: Texture2D  ## The texture for the weapon in the menu, hud.
var texture_game: Texture2D  ## The texture for the weapon in the game.

var level: int = 0  ## The level of the weapon.
var value: int = 0  ## The value of the weapon, determines buy and sell price.

var damage: int = 10  ## The damage of the weapon.
var projectiles: int = 1  ## The amount of projectiles the weapon shoots.
#var attack_speed: float = 1.0 ## The attack speed of the weapon.

var cooldown_time: float = 0.5  ## The cooldown time for the weapon.
var cooldown: Tween


func _ready() -> void:
	pass


# Override in children.
func attack() -> void:
	pass
