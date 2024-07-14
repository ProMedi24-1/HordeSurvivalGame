class_name GEntityAdmin extends Node
## GEntityAdmin is responsible for managing all entities,
## including registration and tracking of the player.

static var entities := []  ## Static array to hold all registered entities.
static var player: Player  ## Static reference to the player entity.


func _ready() -> void:
	self.name = "GEntityAdmin"


## Registers an entity with the entity manager.
## [entity]: The entity to register, can be of any type derived from Node.
static func register_entity(entity: Node) -> void:
	entities.append(entity)

	if entity is Player:
		player = entity
		#GLogger.log("GEntityAdmin: Registered player: " + str(entity), Color.PURPLE)
	#else:
		#GLogger.log("GEntityAdmin: Registered entity: " + str(entity), Color.PURPLE)


# Unregisters an entity from the entity manager.
# [entity]: The entity to unregister.
static func unregister_entity(entity: Node) -> void:
	entities.erase(entity)
