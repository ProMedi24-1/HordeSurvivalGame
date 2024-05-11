class_name MovementBaseComponent
extends Node2D

## Signals emitted when the entity starts and stops moving.
signal movement_started
signal movement_stopped

@export var entity: Node2D ## The node that this component is attached to, and will be used to move.
@export var stats_component: Node2D ## The node that handles the entity stats.

## Indicates whether the entity is currently moving.
var is_moving: bool

## TODO: Fix jittery movement on higher framerates.

## The _physics_process function is called during the physics processing phase of the main loop.
## It handles the movement of the player node.
func _physics_process(delta: float) -> void:
    ## Updates the player's movement based on user input and delta time.
    ## @param delta: The time elapsed since the last frame.
    
    handle_movement(delta)
    entity.move_and_slide()

# OVERRIDE
func handle_movement(_delta) -> void:
    pass
