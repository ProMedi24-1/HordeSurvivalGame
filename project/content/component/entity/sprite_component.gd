extends Sprite2D

@export var movement_component: Node2D

@export var rotate_sprite: bool = true

func _ready() -> void:
	#movement_component.connect("movement_started", _on_movement_started)
	pass

# func _on_movement_started() -> void:
#     #print(movement_component.entity.velocity) 
#     if rotate_sprite:
#         if movement_component.entity.velocity.x > 0:
#             self.flip_h = true


