extends Node

func _ready() -> void:
	GSceneAdmin.addSceneToMap("TitleScreen", GStateAdmin.GameState.TITLE_SCREEN, "res://content/ui/title_screen/title_screen.tscn")
	GSceneAdmin.addSceneToMap("MainMenu", GStateAdmin.GameState.MAIN_MENU, "res://content/ui/main_menu/main_menu.tscn")	
	GSceneAdmin.addSceneToMap("PrototypeLevel", GStateAdmin.GameState.PLAYING, "res://content/level/prototype_level.tscn")
	GLogger.log("SceneRegistry ready", Color.WHITE)
	
