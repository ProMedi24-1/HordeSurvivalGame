class_name WeaponUtils
extends Object

static func getClosestEnemy(node: Node2D, rangeArea: Area2D) -> Node2D:
    var closestEnemy = null
    var closestDistance = INF

    for body in rangeArea.get_overlapping_bodies():
        var distance = node.global_position.distance_to(body.global_position)

        if distance < closestDistance:
            closestDistance = distance
            closestEnemy = body

    return closestEnemy
