class_name HurtBoxComponent
extends Area2D

@export var stats: StatsComponent

var cooldown = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

	cooldown.wait_time = stats.melee_cooldown
	cooldown.one_shot = false
	cooldown.connect("timeout", damage_player)
	add_child(cooldown)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		damage_player()
		cooldown.start()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		cooldown.stop()
		

func damage_player() -> void:
	var player = GameGlobals.entity_admin.player
	player.health.take_damage(stats.melee_damage)

	GameGlobals.logger.log("Melee hurt player: " + str(stats.melee_damage) + " damage", Color.RED)


