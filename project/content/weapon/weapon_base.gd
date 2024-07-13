class_name WeaponBase extends Node2D
## Base class for all weapons.

const LEVEL_MULTIPLIER: float = 1.3  ## The multiplier for the next level requirement.

var texture_menu: Texture2D  ## The texture for the weapon in the menu, hud.
var texture_game: Texture2D  ## The texture for the weapon in the game.
var weapon_name: String ## The name of the weapon.
var weapon_slot: int = 0  ## The slot the weapon is in.

var level: int = 0  ## The level of the weapon.
var level_progress: int = 0  ## The progress towards the next level.
var level_required: int = 0  ## The level required to unlock the weapon.



var damage: int = 5  ## The damage of the weapon.
#var projectiles: int = 1  ## The amount of projectiles the weapon shoots.
#var attack_speed: float = 1.0 ## The attack speed of the weapon.

var cooldown_time: float = 0.5  ## The cooldown time for the weapon.
var cooldown: Tween



func _ready() -> void:
	pass

func level_up() -> void:
	## Level up the weapon.
	level += 1
	level_required = int(level_required * LEVEL_MULTIPLIER)
	level_progress = 0

	## Increase the stats
	damage += 5


# Override in children.
func attack() -> void:
	pass
