extends CanvasLayer


@onready var playButton := $ButtonsBox/PlayButton
@onready var settingsButton := $ButtonsBox/SettingsButton
@onready var creditsButton := $ButtonsBox/CreditsButton
@onready var quitButton := $ButtonsBox/QuitButton


func _ready() -> void:
	playButton.connect("pressed", playPressed)
	settingsButton.connect("pressed", settingsPressed)
	creditsButton.connect("pressed", creditsPressed)
	quitButton.connect("pressed", quitPressed)

func playPressed() -> void:
	pass

func settingsPressed() -> void:
	pass

func creditsPressed() -> void:
	pass

func quitPressed() -> void:
	get_tree().quit()
