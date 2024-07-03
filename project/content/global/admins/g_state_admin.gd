class_name GStateAdmin extends Node


enum GameState {
	NONE,
	TITLE_SCREEN,
	MAIN_MENU,
	LEVEL_SELECT,
	PLAYING,
}


static var gameState: GameState           = GameState.NONE
static var gamePaused: bool               = false
static var pauseMenuScene: PackedScene    = preload ("res://content/ui/pause_menu/pause_menu.tscn")
static var pauseMenuInstance: CanvasLayer = null


func _ready() -> void:
	self.name = "GStateAdmin"
	GLogger.log("GStateAdmin: Ready", Color.GREEN_YELLOW)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PauseMenu") and gameState == GameState.PLAYING:
		GStateAdmin.togglePauseGame()


static func togglePauseGame() -> void:
	if gameState == GameState.PLAYING:
		if gamePaused:
			unpauseGame()
		else:
			pauseGame()


static func pauseGame() -> void:
	GSceneAdmin.sceneRoot.process_mode = Node.PROCESS_MODE_DISABLED
	pauseMenuInstance = pauseMenuScene.instantiate()
	GGameGlobals.instance.add_child(pauseMenuInstance)

	gamePaused = true


static func unpauseGame() -> void:
	GSceneAdmin.sceneRoot.process_mode = Node.PROCESS_MODE_INHERIT
	
	if pauseMenuInstance:
		pauseMenuInstance.queue_free()

	gamePaused = false
