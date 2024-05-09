extends Node2D

## Signal emitted when the game state changes.
signal game_state_changed(state: GameState, payload: String)

## The current game state.
enum GameState {
    TITLE_SCREEN,
    MAIN_MENU,
    LEVEL_SELECT,
    PLAYING,
}

var current_game_state: GameState = GameState.TITLE_SCREEN

var main_menu_scene: PackedScene = preload("res://scenes/ui/menus/main_menu/main_menu.tscn")
var dev_menus_scene: PackedScene = preload("res://scenes/dev_menus/dev_menus.tscn")

## The main scene loaded: the title screen, the main menu, or the level.
var main_scene: Node2D = null

## Reference to the game manager.
@onready var game_manager: GameManager = $GameManager

## Called when starting the game.
func _ready() -> void:
    change_game_state(GameState.MAIN_MENU)

    if OS.is_debug_build():
        add_child(dev_menus_scene.instantiate())
        print_rich("[color=ORANGE]Debug-Mode: ON[/color]")

func switch_scene(new_scene: PackedScene) -> void:
    if new_scene != null:
        if main_scene != null:
            main_scene.queue_free()

        var scene_instance = new_scene.instantiate()
        add_child(scene_instance)
        main_scene = scene_instance
    else:
        print("Cannot change to null scene")   

func change_game_state(state: GameState, payload: String = "") -> void:
    game_state_changed.emit(state, payload)
    print_rich("[color=ORANGE]GameState changed to: %s with payload: {%s} [/color]" % [state, payload])

func _on_game_state_changed(state: GameState, payload: String) -> void:
    if state == current_game_state:
        return

    current_game_state = state

    match state:
        GameState.TITLE_SCREEN:
            pass
        GameState.MAIN_MENU:
            switch_scene(main_menu_scene)
            pass
        GameState.LEVEL_SELECT:
            pass
        GameState.PLAYING:
            switch_scene(game_manager.load_level(payload))
            pass
