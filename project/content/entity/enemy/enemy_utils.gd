class_name EnemyUtils
# Helper functions for enemies. 

static func moveToPlayer(movBody: CharacterBody2D, movSpeed: float, delta: float) -> void:
	var player := GEntityAdmin.player
	if player == null or movBody == null:
		return

	var direction := Vector2.ZERO
	
	direction = movBody.global_position.direction_to(player.movBody.global_position)
	
	movBody.velocity = direction.normalized() * movSpeed * delta


static func moveToDirection(movBody: CharacterBody2D, direction: Vector2, movSpeed: float, delta: float) -> void:
	movBody.velocity = direction.normalized() * movSpeed * delta

