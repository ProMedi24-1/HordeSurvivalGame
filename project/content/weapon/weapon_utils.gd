class_name WeaponUtils
## Utility functions for weapons.


## Get the closest enemy to a node (weapon) within a range area.
## [node]: The node to get the closest enemy to.
## [rangeArea]: The area to check for enemies.
static func get_closest_enemy(node: Node2D, range_area: Area2D) -> Node2D:
	var closest_enemy = null
	var closest_distance = INF

	for body in range_area.get_overlapping_bodies():
		var distance = node.global_position.distance_to(body.global_position)

		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = body

	return closest_enemy


## Get the EnemyBase node from a node.
## [node]: The node to get the EnemyBase node from.
static func get_enemy_node(node: Node2D) -> Node2D:
	for child in node.get_children():
		if child is EnemyBase:
			return child

	return null

#static func addWeaponToPlayer(player: Node2D, weapon: Node2D) -> void:
