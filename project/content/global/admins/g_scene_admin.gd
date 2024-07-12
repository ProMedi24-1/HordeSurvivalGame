class_name GSceneAdmin extends Node
## GSceneAdmin is responsible for managing scene transitions
## and scene-related data within the game.

## Map to hold the scene names and their corresponding GameState and resource paths.
static var scene_map := {
	"TitleScreen":
	Pair.new(GStateAdmin.GameState.TITLE_SCREEN, "res://content/ui/title_screen/title_screen.tscn"),
	"MainMenu":
	Pair.new(GStateAdmin.GameState.MAIN_MENU, "res://content/ui/main_menu/main_menu.tscn"),
	"LevelMenu":
	Pair.new(GStateAdmin.GameState.LEVEL_SELECT, "res://content/ui/level_menu/level_menu.tscn"),
	"PrototypeLevel":
	Pair.new(GStateAdmin.GameState.PLAYING, "res://content/level/PrototypeLevel.tscn"),
}

static var scene_root: Node = null  ## Reference to the current scene root node.
static var level_base: LevelBase = null  ## Reference to the LevelBase node in the scene.


func _ready() -> void:
	self.name = "GSceneAdmin"

	GSceneAdmin.fill_level_data()


## Adds a new scene to the scene map for management.
## [scene_name]: The name of the scene to add.
## [scene_state]: The game state associated with the scene.
## [res_path]: The resource path to the scene file.
static func add_scene_to_map(
	scene_name: String, scene_state: GStateAdmin.GameState, res_path: String
) -> void:
	if scene_map.has(scene_name):
		GLogger.log("GSceneAdmin: Scene " + scene_name + " already exists", Color.RED)
		return
	scene_map[scene_name] = Pair.new(scene_state, res_path)


## Switches the current scene to the specified scene.
## [scene_name]: The name of the scene to switch to.
static func switch_scene(scene_name: String) -> void:
	if not scene_map.has(scene_name):
		GLogger.log("GSceneAdmin: Scene " + scene_name + " does not exist", Color.RED)
		return


	GSceneAdmin.scene_root = null
	GSceneAdmin.level_base = null
	GEntityAdmin.entities.clear()
	GEntityAdmin.player = null

	var scene_resource := load(scene_map[scene_name].second)
	var g_instance := GGameGlobals.instance
	g_instance.get_tree().change_scene_to_packed(scene_resource)
	fill_level_data()


## Reloads the current scene.
static func reload_scene() -> void:
	GSceneAdmin.switch_scene(scene_root.name)


## Fills in level-specific data after a scene has been loaded.
static func fill_level_data() -> void:
	await GGameGlobals.instance.get_tree().node_added

	scene_root = GGameGlobals.instance.get_tree().current_scene
	var root_name := scene_root.name

	if not scene_map.has(root_name):
		GLogger.log("GSceneAdmin: WARNING Scene " + root_name + " not in SceneMap", Color.YELLOW)

		# If the scene does not exist in the sceneMap, it is probably a level scene.
		# So we add it, with PLAYING state to be able to switch to it later.
		add_scene_to_map(root_name, GStateAdmin.GameState.PLAYING, scene_root.scene_file_path)

	# Unpause game on scene switch.
	GStateAdmin.unpause_game()
	# Set the GameState.
	GStateAdmin.game_state = scene_map[root_name].first

	# Take the first Node which is of type LevelBase.
	for child in scene_root.get_children():
		if child is LevelBase:
			level_base = child

			GLogger.log("GSceneAdmin: Found LevelBase")
			return

	GLogger.log("GSceneAdmin: Could not find LevelBase")
