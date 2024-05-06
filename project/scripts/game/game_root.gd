extends Node2D

@export var main_menu_scene: PackedScene
@export var dev_menus_scene: PackedScene

func _ready() -> void:
    add_child(main_menu_scene.instantiate())
        
    if OS.is_debug_build():
        add_child(dev_menus_scene.instantiate())
