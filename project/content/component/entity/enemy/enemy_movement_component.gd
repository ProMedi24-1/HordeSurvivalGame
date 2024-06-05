class_name EnemyMovementComponent
extends MovementBaseComponent
## This class manages the movement of an enemy node within the game.

## Handles the enemy movement to the player
func handle_movement(delta) -> void:

	# TODO: Currently handled poorly via group, because im tired... will get fixed soon,
	# should be done with EntityAdmin instead.
	var direction = body.global_position.direction_to(GameGlobals.entity_admin.player.global_position)

	# Here we multiply the speed by delta to make it independent of frame rate.
	body.velocity = direction.normalized() * stats.movement_speed * delta
	
