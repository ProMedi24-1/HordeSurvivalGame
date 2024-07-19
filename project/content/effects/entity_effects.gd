class_name EntityEffects
## Class for entity effects such as damage effects.


## Plays a hit animation on a Node2D. Modulates the node with a hit color.
## [node]: Node2D to play the hit animation on.
## [hit_color]: Color to modulate the node with.
static func play_hit_anim(node: Node2D, hit_color: Color) -> void:

	var dmg_fx := preload("res://content/effects/damage/damage_fx.tscn").instantiate()
	GSceneAdmin.scene_root.add_child(dmg_fx)
	dmg_fx.global_position = node.global_position

	var tween = node.create_tween()
	if node:
		tween.tween_property(node, "modulate", hit_color, 0.2)

	await tween.finished
	if is_instance_valid(node):
		tween.kill()
		node.modulate = Color.WHITE


## Displays damage numbers on a Node2D. Modulates the numbers with a crit color if crit is true.
## [node]: Node2D to display the damage numbers on.
## [amount]: Amount of damage to display.
## [crit]: If true, display the damage numbers in a crit color.
static func add_damage_numbers(node: Node, amount: int, crit: bool = false) -> void:
	var dmg_num := preload("res://content/effects/damage/damage_numbers.tscn").instantiate()
	dmg_num.text = str(amount)

	GSceneAdmin.scene_root.add_child(dmg_num)
	dmg_num.global_position = node.global_position + randf_range(-20, 20) * Vector2(1, 1)

	if crit:
		dmg_num.modulate = Color.RED

	var tween := dmg_num.create_tween()
	tween.tween_property(dmg_num, "modulate:a", 0.0, 0.5)
	tween.tween_callback(dmg_num.queue_free)
