class_name EntityBaseComponent
extends Node

func _ready() -> void:
	GEntityAdmin.registerEntity(self.get_parent())

func _exit_tree() -> void:
	GEntityAdmin.unregisterEntity(self.get_parent())
	
