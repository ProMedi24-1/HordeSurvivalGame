class_name Player
extends Node2D

@onready var stats = $PlayerStatsComponent
@onready var movement = $PlayerMovementComponent
@onready var health = $HealthComponent


@export var hud_res := preload("res://content/ui/hud/hud.tscn")
var hud_scene := hud_res.instantiate()

func _ready():
	# Add HUD to player scene via ready(), this way the HUD is not shown in the Level scenes in the editor.
	add_child(hud_scene)



# func _check_colliding_enemies():
# 	for body in damage_receive_area_2d.get_overlapping_bodies():
# 		if body is Enemy:
# 			health_component.take_damage(body.get_collision_damage())
	

# func _on_damage_receive_area_2d_body_entered(body):
# 	if body is Enemy:
# 		# take damage 
# 		health_component.take_damage(body.get_collision_damage())
		



