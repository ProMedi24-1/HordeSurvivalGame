class_name Player
extends Node2D

@onready var stats_component = $StatsComponent
@onready var movement_component = $PlayerMovementComponent
@onready var health_component = $HealthComponent
@onready var check_damage_timer:Timer = $CheckDamageTimer


@export var health_bar: ProgressBar # TODO make HealthBar
@onready var damage_receive_area_2d = $DamageReceiveArea2D


func _ready():
	health_bar.max_value = stats_component.max_health
	health_bar.update(stats_component.health)


func _unhandled_input(event):
	if Input.is_action_just_pressed("damage"):
		health_component.take_damage(10)
	elif Input.is_action_just_pressed("heal"):
		health_component.take_heal(10)

func _check_colliding_enemies():
	for body in damage_receive_area_2d.get_overlapping_bodies():
		if body is Enemy:
			health_component.take_damage(body.get_collision_damage())
	

func _on_damage_receive_area_2d_body_entered(body):
	if body is Enemy:
		# take damage 
		health_component.take_damage(body.get_collision_damage())
		



