class_name PlayerMovementComponent
extends Node2D
## This class manages the movement of a player node within the game.

## Signals emitted when the player starts and stops moving.
signal movement_started
signal movement_stopped

@export var player: Node2D ## The node that this component is attached to, and will be used to move.
@export var stats: Node2D ## The node that handles the entity stats.

## Indicates whether the player is currently moving.
var is_moving: bool

## TODO: Fix jittery movement on higher framerates.

## The _physics_process function is called during the physics processing phase of the main loop.
## It handles the movement of the player node.
func _physics_process(delta: float) -> void:
    ## Updates the player's movement based on user input and delta time.
    ## @param delta: The time elapsed since the last frame.
    
    handle_movement(delta)
    player.move_and_slide()

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
    player.velocity = direction.normalized() * stats.movement_speed * delta
