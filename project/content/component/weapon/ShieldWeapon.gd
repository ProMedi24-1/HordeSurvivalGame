extends Weapon

@export var radius: float = 22.0
@onready var sprites = $Sprites
@onready var collision_shape_2d = $Area2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO use radius for sprite and collision shape
	collision_shape_2d.shape.radius = radius
	sprites.scale = Vector2(radius/50.0, radius/50.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotation_dr = 1
	for sprite: Sprite2D in sprites.get_children():
		sprite.rotation_degrees += rotation_dr
		rotation_dr = -rotation_dr

