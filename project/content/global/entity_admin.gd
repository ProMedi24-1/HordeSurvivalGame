class_name EntityAdmin
extends Node

static var entity_map: Dictionary = {
	"Player": preload("res://content/entity/player/player.tscn"),

	"Slime": preload("res://content/entity/enemy/slime/slime.tscn"),

}

static var entities: Array = [] 
static var player: Node

func _ready() -> void:
	GameGlobals.logger.log("EntityAdmin ready", Color.GREEN_YELLOW)

func register_entity(entity: Node) -> void:
	entities.append(entity)

	GameGlobals.logger.log("Entity: " + entity.name + " registered", Color.PINK)

	if entity.is_in_group("Player"):
		player = entity

func deregister_entity(entity: Node) -> void:
	entities.erase(entity)

	GameGlobals.logger.log("Entity: " + entity.name + " deregistered", Color.PINK)

	if entity.is_in_group("Player"):
		player = null

func delete_entity(entity: Node) -> void:
	entity.queue_free()

func spawn_entity_at(entity_name: String, position: Vector2) -> void:
	var entity = entity_map[entity_name].instantiate()
	entity.global_position = position
	SceneAdmin.scene_root.add_child(entity)
	#get_tree().get_root().add_child(entity)
