extends CharacterBody2D

@onready var animation = $FlyAnimation

func _ready() -> void:
	animation.play("fly")
