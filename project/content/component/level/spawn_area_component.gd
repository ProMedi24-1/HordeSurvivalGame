class_name SpawnAreaComponent
extends Area2D

var coll_shape: CollisionShape2D

func _ready() -> void:
	coll_shape = self.get_child(0)
	

	print(get_spawn_point())

func get_spawn_point() -> Vector2:
	var pos = get_random_position()

	# Exclude the cauldron area.
	while Geometry2D.is_point_in_circle(pos, Vector2.ZERO, 50.0):
		pos = get_random_position()

	return pos	


func get_random_position() -> Vector2:
	var rect_shape := coll_shape.shape as RectangleShape2D
	#print(rect_shape)
	
	var random_point = Vector2(
		randf_range(-rect_shape.extents.x, rect_shape.extents.x),
		randf_range(-rect_shape.extents.y, rect_shape.extents.y)
	)

	#Geometry2D.is_point_in_circle(random_point, Vector2.ZERO, rect_shape.extents)
	#rect_shape.contains_point

	#print(random_point)

	return random_point

