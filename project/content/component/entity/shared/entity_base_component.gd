class_name EntityBaseComponent
extends Node

@onready var stats = $PlayerStatsComponent
@onready var movement = $PlayerMovementComponent
@onready var health = $HealthComponent

func _ready() -> void:
	GameGlobals.entity_admin.register_entity(self.get_parent())

func _exit_tree() -> void:
	GameGlobals.entity_admin.deregister_entity(self.get_parent())
	
