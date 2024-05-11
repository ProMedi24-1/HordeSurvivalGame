extends Button

@export var press_sound: AudioStream = preload("res://assets/audio/ui/click_001.ogg")
@export var select_sound: AudioStream = preload("res://assets/audio/ui/select_001.ogg")

@onready var sound_player: AudioStreamPlayer = $SoundPlayer

func _ready() -> void:
    pass
    
func play_sound(sound: AudioStream) -> void:
    sound_player.set_stream(sound)
    sound_player.play()

func _on_pressed() -> void:
    play_sound(press_sound)

func _on_focus_entered() -> void:
    play_sound(select_sound)
