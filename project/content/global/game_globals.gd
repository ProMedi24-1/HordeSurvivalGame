# class_name GameGlobals
extends Node

static var logger: Logger

static var state_admin: StateAdmin
static var scene_admin: SceneAdmin
static var entity_admin: EntityAdmin

static var debug_build: bool = OS.is_debug_build()
static var platform: String = OS.get_name()
static var locale: String = OS.get_locale()

func _init():
	logger = Logger.new()
	add_global_to_tree(logger, "Logger")
	
	if debug_build:
		var debug_menus = DebugMenuBar.new()
		add_child(debug_menus)
		debug_menus.name = "DebugMenuBar"
		debug_menus.add_to_group("DebugMenuBar")
	
	state_admin = StateAdmin.new()
	add_global_to_tree(state_admin, "StateAdmin")

	scene_admin = SceneAdmin.new()
	add_global_to_tree(scene_admin, "SceneAdmin")

	entity_admin = EntityAdmin.new()
	add_global_to_tree(entity_admin, "EntityAdmin")

func _ready() -> void:
	logger.log("GameGlobals ready", Color.GREEN_YELLOW)
	logger.log("Debug-build: %s" % debug_build, Color.YELLOW)
	logger.log("Platform: %s" % platform, Color.YELLOW)
	logger.log("Locale: %s" % locale, Color.YELLOW)

func add_global_to_tree(global: Node, global_name: String) -> void:
	add_child(global)
	global.name = global_name
	global.add_to_group(global_name)
