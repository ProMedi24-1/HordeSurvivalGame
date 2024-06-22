class_name GEntityAdmin
extends Node

static var entities := []
static var player: Player

func _ready() -> void:
	self.name = "GEntityAdmin"
	GLogger.log("GEntityAdmin: Ready", Color.GREEN_YELLOW)

static func registerEntity(entity: Node) -> void:
	entities.append(entity)

	if entity is Player:
		player = entity
		GLogger.log("GEntityAdmin: Registered player: " + str(entity), Color.PURPLE)
	else:
		GLogger.log("GEntityAdmin: Registered entity: " + str(entity), Color.PURPLE)

static func unregisterEntity(entity: Node) -> void:
	entities.erase(entity)
