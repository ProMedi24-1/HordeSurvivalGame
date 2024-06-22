class_name EntityBase
extends Node2D

func _ready() -> void:
    GEntityAdmin.registerEntity(self)

func _exit_tree() -> void:
    GEntityAdmin.unregisterEntity(self)
