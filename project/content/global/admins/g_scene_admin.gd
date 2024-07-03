class_name GSceneAdmin extends Node


# Register all scenes here.
static var sceneMap := {
    "TitleScreen": Utils.Pair.new(GStateAdmin.GameState.TITLE_SCREEN, "res://content/ui/title_screen/title_screen.tscn"),
    "MainMenu": Utils.Pair.new(GStateAdmin.GameState.MAIN_MENU, "res://content/ui/main_menu/main_menu.tscn"),
    "PrototypeLevel": Utils.Pair.new(GStateAdmin.GameState.PLAYING, "res://content/level/PrototypeLevel.tscn"),
}


static var sceneRoot: Node
static var levelBase: LevelBase


func _ready() -> void:
    GSceneAdmin.fillLevelData()

    self.name = "GSceneAdmin"
    GLogger.log("GSceneAdmin: Ready", Color.GREEN_YELLOW)


static func addSceneToMap(sceneName: String, sceneState: GStateAdmin.GameState, resPath: String) -> void:

    if sceneMap.has(sceneName):
        GLogger.log("GSceneAdmin: Scene " + sceneName + " already exists", Color.RED)
        return

    sceneMap[sceneName] = Utils.Pair.new(sceneState, resPath)


static func switchScene(sceneName: String) -> void:
    if not sceneMap.has(sceneName):
        GLogger.log("GSceneAdmin: Scene " + sceneName + " does not exist", Color.RED)
        return

    var sceneResource := load(sceneMap[sceneName].second)
    var gInstance := GGameGlobals.instance
    gInstance.get_tree().change_scene_to_packed(sceneResource)

    fillLevelData()
    #gInstance.get_tree().connect("node_added", fillLevelData, CONNECT_ONE_SHOT)


static func reloadScene() -> void:
    GSceneAdmin.switchScene(sceneRoot.name)


static func fillLevelData() -> void:
    await GGameGlobals.instance.get_tree().node_added

    sceneRoot = GGameGlobals.instance.get_tree().current_scene
    var rootName := sceneRoot.name

    if not sceneMap.has(rootName):
        GLogger.log("GSceneAdmin: WARNING Scene " + rootName + " not in SceneMap", Color.YELLOW)

        # If the scene does not exist in the sceneMap, it is probably a level scene.
        # So we add it, with PLAYING state to be able to switch to it later.
        addSceneToMap(rootName, GStateAdmin.GameState.PLAYING, sceneRoot.scene_file_path)
    
    # Unpause game on scene switch.
    GStateAdmin.unpauseGame()
    # Set the GameState.
    GStateAdmin.gameState = sceneMap[rootName].first

    # Take the first Node which is of type LevelBase.
    for child in sceneRoot.get_children():
        if child is LevelBase:
            levelBase = child

            GLogger.log("GSceneAdmin: Found LevelBase")
            return

    GLogger.log("GSceneAdmin: Could not find LevelBase")
