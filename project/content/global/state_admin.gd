class_name StateAdmin
extends Node

signal game_state_changed(state: GameState)

enum GameState {
    NONE,
    TITLE_SCREEN,
    MAIN_MENU,
    LEVEL_SELECT,
    PLAYING,
}

static var enum_strings: Array = [
    "NONE",
    "TITLE_SCREEN",
    "MAIN_MENU",
    "LEVEL_SELECT",
    "PLAYING",
]

static var current_game_state = GameState.NONE

static var game_paused: bool = false

func _ready() -> void:
    game_state_changed.connect(_on_game_state_changed)

    # Set the GameState based on the initial scene. Also check wether the scene is registered
    # in the SceneAdmin. If not, set it to PLAYING.
    if SceneAdmin.scenes.has(get_tree().current_scene.name):
        current_game_state = SceneAdmin.scenes[get_tree().current_scene.name].get_first()
    else: 
        current_game_state = GameState.PLAYING
    
    GameGlobals.logger.log("StateAdmin ready", Color.GREEN_YELLOW)

func change_game_state(state: GameState) -> void:
    current_game_state = state
    game_state_changed.emit(state)
    
func _on_game_state_changed(state: GameState) -> void:
    GameGlobals.logger.log("StateAdmin: GameState changed to: %s" % enum_strings[state], Color.PINK)



func _input(event: InputEvent) -> void:
    if event.is_action_pressed("PauseMenu"):

        if current_game_state == GameState.PLAYING:
            if game_paused:
                SceneAdmin.current_scene_root.process_mode = Node.PROCESS_MODE_INHERIT
                game_paused = false
            else:
                SceneAdmin.current_scene_root.process_mode = Node.PROCESS_MODE_DISABLED
                game_paused = true