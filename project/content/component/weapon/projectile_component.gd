class_name ProjectileComponent
extends Node2D

@export var body: Node2D
@export var speed: float = 10.0
@export var homing: bool = false

var direction = Vector2(0, 1)
var target = Node2D
#func _ready() -> void:

func _physics_process(delta: float) -> void:
	# Move into a constant direction: 
	body.position += direction * speed * delta
