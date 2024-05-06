extends Node2D

@onready var play_button = $MenuLayer/MenuRoot/VFlowContainer/PlayButton
@onready var settings_button = $MenuLayer/MenuRoot/VFlowContainer/SettingsButton
@onready var quit_button = $MenuLayer/MenuRoot/VFlowContainer/QuitButton

var audio_player = AudioStreamPlayer.new()

@export var click_sound: AudioStream 

func _ready() -> void:
    add_child(audio_player)

func play_sound(sound: AudioStream) -> void:
    audio_player.set_stream(sound)
    audio_player.play()

func play_press_sound() -> void:
    var player = AudioStreamPlayer.new()
    add_child(player)
    var sound = load("res://assets/audio/ui/click_001.ogg")
    player.set_stream(sound)
    player.play()
    

func _on_play_button_pressed() -> void:
    #play_press_sound()
    play_sound(click_sound)
    pass # Replace with function body.

func _on_quit_button_pressed() -> void:
    print_rich("[color=YELLOW]Quitting Game[/color]")
    get_tree().quit()


func _on_play_button_focus_entered() -> void:
    play_sound(click_sound)
    pass # Replace with function body.
