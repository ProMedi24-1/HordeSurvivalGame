class_name EntityAdmin
extends Node

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

	GameGlobals.logger.log("test", Color.WHITE)

	if entity.is_in_group("Player"):
		player = null

func delete_entity(entity: Node) -> void:
	entity.queue_free()


