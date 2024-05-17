class_name SceneAdmin
extends Node

signal scene_switched()

# All Scenes and Levels should be registered here.
static var scenes: Dictionary = {
    "TitleScreen": Pair.new(StateAdmin.GameState.TITLE_SCREEN, "res://content/ui/title_screen/title_screen.tscn"),
    "MainMenu": Pair.new(StateAdmin.GameState.MAIN_MENU, "res://content/ui/main_menu/main_menu.tscn"),
    "PrototypeLevel": Pair.new(StateAdmin.GameState.PLAYING, "res://content/level/prototype_level.tscn"),
}

static var current_scene_resource: PackedScene = null
static var current_scene_root: Node = null

func _ready() -> void:
    scene_switched.connect(_on_scene_switched)

    # Set the scene root reference based on the initial scene
    current_scene_root = get_tree().current_scene

    # Check if the scene is registered in the Scenes Dictionary.
    if not scenes.has(current_scene_root.name):
        GameGlobals.logger.log("SceneAdmin: WARNING Scene not registered in SceneAdmin-Dictionary: " + current_scene_root.name, Color.RED)
    
    GameGlobals.logger.log("SceneAdmin ready", Color.GREEN_YELLOW)

func switch_scene(scene: String) -> void:
    if scene == current_scene_root.name:
        GameGlobals.logger.log("SceneAdmin: Already on scene: " + scene, Color.RED)
        return

    if not scenes.has(scene):
        GameGlobals.logger.log("SceneAdmin: Unknown scene requested: " + scene, Color.RED)
        return

    if not ResourceLoader.exists(scenes[scene].get_second()):
        GameGlobals.logger.log("SceneAdmin: SceneResource not found: " + scenes[scene].get_second(), Color.RED)
        return

    current_scene_resource = load(scenes[scene].get_second())
    get_tree().change_scene_to_packed(current_scene_resource)

    # Wait until the scene is loaded and added to the scene tree, 
    # then set the current scene root. 
    update_current_scene()

func update_current_scene() -> void:
    await get_tree().node_added

    # TODO: Handle Error, when scene root node does not have the correct name.
    current_scene_root = get_tree().current_scene
    GameGlobals.state_admin.change_game_state(scenes[current_scene_root.name].get_first())
    
    scene_switched.emit()

func _on_scene_switched() -> void:
    # Unpause game on scene switch.
    #StateAdmin.game_paused = false

    GameGlobals.logger.log("SceneAdmin: Switched to scene: " + current_scene_root.name, Color.PINK)
    GameGlobals.logger.log("SceneAdmin: New current scene root: " + str(current_scene_root), Color.PINK)
    
    
