class_name PlayerMovementComponent
extends MovementBaseComponent
## This class manages the movement of a player node within the game.


## Handles the movement of the player based on user input.
func handle_movement(delta) -> void:
	## Updates the player's velocity based on user input and the player's stats.
	## @param delta: The time elapsed since the last frame.

	# Handle directional inputs
	var direction = Vector2.ZERO
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")

	if direction != Vector2.ZERO:
		if !is_moving:
			movement_started.emit()
			is_moving = true
	else:
		if is_moving:
			movement_stopped.emit()
			is_moving = false

	# Here we multiply the speed by delta to make it independent of frame rate.
	body.velocity = direction.normalized() * stats_component.movement_speed * delta
