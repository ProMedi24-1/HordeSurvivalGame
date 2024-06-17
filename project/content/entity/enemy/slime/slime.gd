
extends EntityBaseComponent
#TODO make Enemy script to use for all enemies
@onready var sprite_component = $SpriteComponent
@onready var animation_player = $AnimationPlayer


@export var evolution_stats: Array[EnemyStatsComponent] = [] # TODO use evolution also in other components
@export var current_evolution: int = 0

func _ready():
	sprite_component.texture = evolution_stats[current_evolution].texture


func _on_health_component_died():
	queue_free()


func _on_health_component_damaged(amount):
	animation_player.play("take_damage")
