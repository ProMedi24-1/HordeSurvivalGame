class_name GStateAdmin extends Node
## GStateAdmin is responsible for managing the game state,
## including pausing and unpausing the game.

## Enum to represent the various states the game can be in.
enum GameState {
	NONE,  ## Initial state, or no specific state.
	TITLE_SCREEN,  ## When the game is at the title screen.
	MAIN_MENU,  ## When the game is at the main menu.
	LEVEL_SELECT,  ## When the player is selecting a level.
	PLAYING,  ## When in a level or undefined scene.
}

## The scene used for the pause menu.
const PAUSE_MENU_SCENE: PackedScene = preload("res://content/ui/pause_menu/pause_menu.tscn")


## Static variable to hold the current game state.
static var game_state: GameState = GameState.NONE
## Static boolean to track if the game is paused.
static var game_paused: bool = false



func _ready() -> void:
	self.name = "GStateAdmin"


## Pauses the game on input.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PauseMenu") and game_state == GameState.PLAYING:
		GStateAdmin.toggle_pause_game()


## Toggles the pause state of the game.
static func toggle_pause_game() -> void:
	if game_state == GameState.PLAYING:
		if game_paused:
			unpause_game()
		else:
			pause_game()


## Pauses the game by disabling the processing of the main scene.
static func pause_game(gameover: bool = false) -> void:
	if GSceneAdmin.scene_root != null:
		GSceneAdmin.scene_root.process_mode = Node.PROCESS_MODE_DISABLED

	if not gameover:
		var pause_menu_instance := PAUSE_MENU_SCENE.instantiate()
		GGameGlobals.instance.add_child(pause_menu_instance)

	game_paused = true


## Unpauses the game by enabling the processing of the main scene.
static func unpause_game() -> void:
	GSceneAdmin.scene_root.process_mode = Node.PROCESS_MODE_INHERIT

	#if pauseMenuInstance:
	#pauseMenuInstance.queue_free()

	game_paused = false
