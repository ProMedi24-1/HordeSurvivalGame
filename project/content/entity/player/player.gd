class_name PlayerCool
extends Node2D

@onready var stats = $PlayerStatsComponent
@onready var movement = $PlayerMovementComponent
@onready var health = $HealthComponent


@export var hud_res := preload("res://content/ui/hud/hud.tscn")
var hud_scene := hud_res.instantiate()

func _ready():
	# Add HUD to player scene via ready(), this way the HUD is not shown in the Level scenes in the editor.
	add_child(hud_scene)

